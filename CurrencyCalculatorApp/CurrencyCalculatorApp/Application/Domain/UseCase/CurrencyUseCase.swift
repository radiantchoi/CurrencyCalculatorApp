//
//  CurrencyUseCase.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine

protocol CurrencyUseCase {
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError>
}

final class CurrencyUseCaseImpl: CurrencyUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        return repository.getCurrencyInfo()
    }
}
