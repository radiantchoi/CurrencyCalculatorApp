//
//  CurrencyUseCaseTests.swift
//  CurrencyCalculatorAppTests
//
//  Created by Gordon Choi on 12/18/23.
//

import XCTest
@testable import CurrencyCalculatorApp

import Combine

final class MockRepositoryImpl: CurrencyRepository {
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        return Future { promise in
            promise(.success(Currency.example))
        }
        .eraseToAnyPublisher()
    }
}

final class FailingRepositoryImpl: CurrencyRepository {
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        return Future { promise in
            promise(.failure(.failedToDecode))
        }
        .eraseToAnyPublisher()
    }
}

final class CurrencyUseCaseTests: XCTestCase {
    var sut: CurrencyUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = CurrencyUseCaseImpl(repository: MockRepositoryImpl())
        cancellables = Set<AnyCancellable>()
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
        
        try super.tearDownWithError()
    }
    
    func test_repository에서_넘어오는_자료를_잘_반환하는지() {
        // given
        let expected = Currency.example
        
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
    
    func test_repository에서_넘어오는_에러를_잘_반환하는지() {
        // given
        let expected = FetchingError.failedToDecode
        sut = CurrencyUseCaseImpl(repository: FailingRepositoryImpl())
        
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
    
    func test_값이_올바를경우_값을_반환하는지() {
        // given
        let inputValue = "3000"
        
        // when
        let result = sut.verifyCurrencyValue(inputValue)
        
        // then
        XCTAssertEqual(result, 3000)
    }
    
    func test_값이_범위를초과할경우_nil을_반환하는지() {
        // given
        let inputValue = "30000"
        
        // when
        let result = sut.verifyCurrencyValue(inputValue)
        
        // then
        XCTAssertNil(result)
    }
    
    func test_값이_숫자가_아닐경우_nil을_반환하는지() {
        // given
        let inputValue = "....."
        
        // when
        let result = sut.verifyCurrencyValue(inputValue)
        
        // then
        XCTAssertNil(result)
    }
}
