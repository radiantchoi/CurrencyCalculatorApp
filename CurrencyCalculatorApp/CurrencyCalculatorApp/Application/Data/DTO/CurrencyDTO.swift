//
//  CurrencyDTO.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

struct CurrencyDTO: Decodable {
    let timestamp: Int
    let quotes: CurrencyQuotes
    
    func toModel() -> Currency {
        let timestamp = Date(timeIntervalSince1970: TimeInterval(timestamp))

        return Currency(timestamp: timestamp,
                        toKRW: quotes.toKRW,
                        toJPY: quotes.toJPY,
                        toPHP: quotes.toPHP)
    }
}

struct CurrencyQuotes: Decodable {
    let toKRW: Double
    let toJPY: Double
    let toPHP: Double
    
    enum CodingKeys: String, CodingKey {
        case toKRW = "USDKRW"
        case toJPY = "USDJPY"
        case toPHP = "USDPHP"
    }
}
