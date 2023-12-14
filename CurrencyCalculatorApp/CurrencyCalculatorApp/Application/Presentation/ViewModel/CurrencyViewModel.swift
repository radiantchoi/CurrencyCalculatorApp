//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

enum Country: String {
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
    
    @Published private var USDtoKRW: Double = 0
    @Published private var USDtoJPY: Double = 0
    @Published private var USDtoPHP: Double = 0
    
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
                self.timestamp = $0.timestamp.formatStamp()
                self.USDtoKRW = $0.toKRW
                self.USDtoJPY = $0.toJPY
                self.USDtoPHP = $0.toPHP
                
                self.setSelectedCurrency(self.selectedCountry)
            }
            .store(in: &cancellables)
    }
    
    private func bindCurrencyInfo() {
        $selectedCountry
            .sink {
                self.setSelectedCurrency($0)
            }
            .store(in: &cancellables)
    }
    
    private func setSelectedCurrency(_ country: Country) {
        switch country {
        case .korea:
            selectedCurrency = USDtoKRW
        case .japan:
            selectedCurrency = USDtoJPY
        case .philippines:
            selectedCurrency = USDtoPHP
        }
    }
}
