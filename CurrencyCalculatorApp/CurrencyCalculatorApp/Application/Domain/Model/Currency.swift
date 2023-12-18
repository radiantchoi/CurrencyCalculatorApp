//
//  Currency.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

struct Currency: Equatable {
    let timestamp: Date
    let toKRW: Double
    let toJPY: Double
    let toPHP: Double
}

extension Currency {
    static let example = Currency(timestamp: Date(), toKRW: 1300, toJPY: 140, toPHP: 55)
}
