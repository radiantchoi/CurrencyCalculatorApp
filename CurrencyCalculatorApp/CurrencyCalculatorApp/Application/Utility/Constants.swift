//
//  Constants.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/18/23.
//

import Foundation

enum NumberProcessing {
    static func roundToTwo(_ number: Double) -> Double {
        let result = round(number * 100) / 100
        return result
    }
}

extension String {
    enum CurrencyViewControllerValues {
        static let placeholderValue = "---"
        static let titleLabelText = "환율 계산"
        static let sendingSectionLabelText = "송금국가 : "
        static let receivingSectionLabelText = "수취국가 : "
        static let currencySectionLabelText = "환율 : "
        static let dateSectionLabelText = "조회시간 : "
        static let moneySectionLabelText = "송금액 : "
        static let sendingLabelText = "미국 (USD)"
        static let moneyUnitLabelText = "USD"
        static let resultLabelPlaceholderText = "수취 예정 금액이 표시됩니다."
        static let selectCountryButtonTitle = "수취 국가 변경"
        static let errorTitle = "Error!"
        static let selectCountrySheetTitle = "수취 국가 선택"
        static let cancelSheetText = "취소"
        static let invalidTransactionText = "송금액이 바르지 않습니다."
        
        static func resultLabelText(_ money: Sending) -> String {
            "수취금액은 \(money.amount) \(money.currency) 입니다."
        }
    }
    
    enum EndpointValues {
        static let accessKey = "bd9bd75624cbe4e1cb66d7f69ad4f55a"
        static let targetCurrencies = "KRW,JPY,PHP"
        static let sourceCurrency = "USD"
    }
}

extension CGFloat {
    enum CurrencyViewControllerValues {
        static let titleLabelFontSize: CGFloat = 48
        static let stackViewVerticalSpacing: CGFloat = 16
        static let stackViewHorizontalSpacing: CGFloat = 8
        static let titleLabelTopConstant: CGFloat = 48
        static let titleLabelBottomConstant: CGFloat = 16
        static let contentStackViewRatio: CGFloat = 0.75
        static let moneyInputTextFieldHeight: CGFloat = 22
        static let moneyInputTextFieldRatio: CGFloat = 1/3
        static let resultLabelTopConstant: CGFloat = 64
        static let selectCountryButtonTopConstant: CGFloat = 32
    }
}
