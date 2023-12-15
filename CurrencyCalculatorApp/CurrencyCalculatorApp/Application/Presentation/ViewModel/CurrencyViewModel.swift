//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

enum Country: String, CaseIterable {
    case korea = "대한민국"
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

struct Sending {
    let currency: String
    let amount: Double
}

final class CurrencyViewModel {
    private let useCase: CurrencyUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var currencyInfo: Currency = Currency.example
    
    @Published private(set) var timestamp: String = "---"
    @Published private(set) var selectedCountry: Country = .korea {
        didSet {
            changeMoneyValue(inputMoney)
        }
    }
    @Published private(set) var selectedCurrency: Double = 0

    private var inputMoney: Double = 0
    @Published private(set) var sendingMoney: Sending = Sending(currency: "KRW", amount: 0)
    
    @Published private(set) var fetchingError: FetchingError? = nil
    
    init(useCase: CurrencyUseCase = CurrencyUseCaseImpl()) {
        self.useCase = useCase
        
        bindCurrencyInfo()
        fetchCurrencyInfo()
    }
    
    private func fetchCurrencyInfo() {
        useCase.getCurrencyInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    self?.fetchingError = error
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
    
    func verifyInputValue(_ value: String?) -> Double? {
        guard let value,
              let number = Double(value),
              (0...10000) ~= number else {
            return nil
        }
        
        return number
    }
    
    func changeMoneyValue(_ value: Double) {
        inputMoney = value
        let newSendingMoneyAmount = round(selectedCurrency * inputMoney * 100) / 100
        sendingMoney = Sending(currency: selectedCountry.currency, amount: newSendingMoneyAmount)
    }
}
