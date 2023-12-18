//
//  CurrencyRepositoryTests.swift
//  CurrencyCalculatorAppTests
//
//  Created by Gordon Choi on 12/18/23.
//

import XCTest
@testable import CurrencyCalculatorApp

import Combine

struct MockWebService: WebServiceable {
    func call(_ endpoint: Endpoint) -> AnyPublisher<Data, FetchingError> {
        return Future { promise in
            let mockJson = """
                {
                    "success": true,
                    "terms": "https://currencylayer.com/terms",
                    "privacy": "https://currencylayer.com/privacy",
                    "timestamp": 1702893304,
                    "source": "USD",
                    "quotes": {
                        "USDKRW": 1299.070079,
                        "USDJPY": 142.418936,
                        "USDPHP": 55.825999
                    }
                }
            """
            let data = Data(mockJson.utf8)
            promise(.success(data))
        }
        .eraseToAnyPublisher()
    }
}

struct FailingWebService: WebServiceable {
    func call(_ endpoint: Endpoint) -> AnyPublisher<Data, FetchingError> {
        return Future { promise in
            promise(.failure(FetchingError.failedToGetHTTPResponse))
        }
        .eraseToAnyPublisher()
    }
}

struct NotDecodableWebService: WebServiceable {
    func call(_ endpoint: Endpoint) -> AnyPublisher<Data, FetchingError> {
        return Future { promise in
            let mockJson = """
                {
                    "success": true,
                    "message": "Hello, this is failing Data!"
                }
            """
            let data = Data(mockJson.utf8)
            promise(.success(data))
        }
        .eraseToAnyPublisher()
    }
}

final class CurrencyRepositoryTests: XCTestCase {
    var sut: CurrencyRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        cancellables = Set<AnyCancellable>()
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
        
        try super.tearDownWithError()
    }

    func test_json응답을_받아서_디코딩결과를_받을수있는지() {
        // given
        let expected = Currency(timestamp: Date(timeIntervalSince1970: TimeInterval(1702893304)), toKRW: 1299.070079, toJPY: 142.418936, toPHP: 55.825999)
        sut = CurrencyRepositoryImpl(service: MockWebService())
        
        // when
        sut.getCurrencyInfo()
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTAssert(true)
                case .failure(_):
                    XCTAssert(false)
                }
            }) {
                XCTAssertEqual($0, [expected])
            }
            .store(in: &cancellables)
    }
    
    func test_웹서비스에서_오류를발신하면_알맞게반환하는지() {
        // given
        let expected = FetchingError.failedToGetHTTPResponse
        sut = CurrencyRepositoryImpl(service: FailingWebService())
        
        // when
        sut.getCurrencyInfo()
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTAssert(false)
                case .failure(let error):
                    XCTAssertEqual(error, expected)
                }
            }) { _ in }
            .store(in: &cancellables)
    }
    
    func test_디코딩에_실패했을때_알맞는오류를_반환하는지() {
        // given
        let expected = FetchingError.failedToDecode
        sut = CurrencyRepositoryImpl(service: NotDecodableWebService())
        
        // when
        sut.getCurrencyInfo()
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTAssert(false)
                case .failure(let error):
                    XCTAssertEqual(error, expected)
                }
            }) { _ in }
            .store(in: &cancellables)
    }
}
