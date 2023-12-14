//
//  CurrencyRepository.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine

protocol CurrencyRepository {
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError>
}
