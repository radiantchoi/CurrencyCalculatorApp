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
    
    /// DTO를 모델로 변환하는 메서드입니다.
    /// 소수 두 번째 자리 반올림은 아직 진행하지 않습니다.
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
