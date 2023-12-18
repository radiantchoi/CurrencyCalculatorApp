//
//  CurrencyRepositoryImpl.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {
    private let service: WebServiceable
    
    init(service: WebServiceable = WebService()) {
        self.service = service
    }
    
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        let endpoint = GetCurrencyEndpoint.getRecentCurrency
        
        return service.call(endpoint)
            .decode(type: CurrencyDTO.self, decoder: JSONDecoder())
            .map { response in
                return response.toModel()
            }
            .mapError { error in
                if let error = error as? FetchingError {
                    return error
                } else {
                    return .failedToDecode
                }
            }
            .eraseToAnyPublisher()
    }
}
