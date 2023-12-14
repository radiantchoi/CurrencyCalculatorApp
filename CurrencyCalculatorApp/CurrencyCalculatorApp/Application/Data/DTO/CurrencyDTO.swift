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
        let krw = round(quotes.toKRW * 100) / 100
        let jpy = round(quotes.toJPY * 100) / 100
        let php = round(quotes.toPHP * 100) / 100

        return Currency(timestamp: timestamp,
                        toKRW: krw,
                        toJPY: jpy,
                        toPHP: php)
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
