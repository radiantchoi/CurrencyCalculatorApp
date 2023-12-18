//
//  WebService.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

protocol WebServiceable {
    func call(_ endpoint: Endpoint) -> AnyPublisher<Data, FetchingError>
}

/// 네트워크 통신을 요청하고, 결과를 반환하는 서비스 오브젝트입니다.
/// call 메서드를 통해 네트워크 요청을 진행합니다.
struct WebService: WebServiceable {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func call(_ endpoint: Endpoint) -> AnyPublisher<Data, FetchingError> {
        guard let request = try? endpoint.toURLRequest() else {
            return Fail(error: .failedToCreateRequest)
                .eraseToAnyPublisher()
        }
        
        return call(request)
    }
    
    private func call(_ request: URLRequest) -> AnyPublisher<Data, FetchingError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw FetchingError.failedToGetHTTPResponse
                }
                
                guard (200...399).contains(httpResponse.statusCode) else {
                    throw FetchingError.invalidNetworkStatusCode(code: httpResponse.statusCode)
                }
                
                return data
            }
            .mapError { error in
                if let networkingError = error as? FetchingError {
                    return networkingError
                } else {
                    return .unknownError(error: error)
                }
            }
            .eraseToAnyPublisher()
    }
}
