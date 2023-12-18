//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

/// 선택한 국가와 해당 국가의 통화 단위를 연결한 타입입니다.
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

/// 송금 금액 레이블에 화폐 단위와 금액을 기재하기 위한 타입입니다.
struct Sending {
    let currency: String
    let amount: Double
    
    static let example = Sending(currency: "KRW", amount: 0)
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
    @Published private(set) var sendingMoney: Sending = Sending.example
    
    @Published private(set) var fetchingError: FetchingError? = nil
    
    init(useCase: CurrencyUseCase = CurrencyUseCaseImpl()) {
        self.useCase = useCase
        
        bindCurrencyInfo()
        fetchCurrencyInfo()
    }
    
    /// 환율 정보를 받아 와서 뷰 모델에 반영하는 메서드입니다.
    private func fetchCurrencyInfo() {
        useCase.getCurrencyInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    LogPrinter.print(result)
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
    
    /// 사용자가 선택한 국가를 뷰 모델에 반영하는 메서드입니다.
    func selectCountry(_ country: Country) {
        selectedCountry = country
    }
    
    /// 선택한 국가가 바뀌면, 선택한 화폐 단위도 바뀌게 하는 메서드입니다.
    private func bindCurrencyInfo() {
        $selectedCountry
            .sink { [weak self] country in
                self?.setSelectedCurrency(country)
            }
            .store(in: &cancellables)
    }
    
    /// 선택한 국가에 따라 현재 적용할 환율을 정하는 메서드입니다.
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
    
    /// 사용자의 입력값이 앱에서 정한 정책과 맞는지 검증하는 메서드입니다.
    func verifyInputValue(_ value: String?) -> Double? {
        useCase.verifyCurrencyValue(value)
    }
    
    /// 송금 예정 금액을 변경하는 메서드입니다.
    func changeMoneyValue(_ value: Double) {
        inputMoney = value
        let newSendingMoneyAmount = NumberProcessing.roundToTwo(selectedCurrency * inputMoney)
        sendingMoney = Sending(currency: selectedCountry.currency, amount: newSendingMoneyAmount)
    }
}
