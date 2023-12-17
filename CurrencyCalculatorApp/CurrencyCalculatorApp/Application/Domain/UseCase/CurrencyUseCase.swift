//
//  CurrencyUseCase.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine

protocol CurrencyUseCase {
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError>
    func verifyCurrencyValue(_ value: String?) -> Double?
}

final class CurrencyUseCaseImpl: CurrencyUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        return repository.getCurrencyInfo()
    }
    
    func verifyCurrencyValue(_ value: String?) -> Double? {
        guard let value,
              let number = Double(value),
              (0...10000) ~= number else {
            return nil
        }
        
        return number
    }
}
