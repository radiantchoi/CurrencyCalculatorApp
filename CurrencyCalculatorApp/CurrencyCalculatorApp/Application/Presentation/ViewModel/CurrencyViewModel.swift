//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

enum Country: String, CaseIterable {
    case korea = "한국"
    case japan = "일본"
    case philippines = "필리핀"
    
    var currency: String {
        switch self {
        case .korea:
            return "KRW"
        case .japan:
            return "JPY"
        case .philippines:
            return "PHP"
        }
    }
}

final class CurrencyViewModel {
    private let useCase: CurrencyUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var currencyInfo: Currency = Currency.example
    
    @Published private(set) var timestamp: String = "---"
    @Published private(set) var selectedCountry: Country = .korea
    @Published private(set) var selectedCurrency: Double = 0
    
    init(useCase: CurrencyUseCase = CurrencyUseCaseImpl()) {
        self.useCase = useCase
        
        bindCurrencyInfo()
        fetchCurrencyInfo()
    }
    
    private func fetchCurrencyInfo() {
        useCase.getCurrencyInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failure \(error)")
                }
            }) {
                self.currencyInfo = $0
                self.timestamp = $0.timestamp.formatStamp()
                
                self.setSelectedCurrency(self.selectedCountry)
            }
            .store(in: &cancellables)
    }
    
    func selectCountry(_ country: Country) {
        selectedCountry = country
    }
    
    private func bindCurrencyInfo() {
        $selectedCountry
            .sink { [weak self] country in
                self?.setSelectedCurrency(country)
            }
            .store(in: &cancellables)
    }
    
    private func setSelectedCurrency(_ country: Country) {
        switch country {
        case .korea:
            selectedCurrency = currencyInfo.toKRW
        case .japan:
            selectedCurrency = currencyInfo.toJPY
        case .philippines:
            selectedCurrency = currencyInfo.toPHP
        }
    }
}
