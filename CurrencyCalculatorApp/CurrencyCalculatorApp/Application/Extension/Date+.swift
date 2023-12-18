//
//  Date+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

extension Date {
    /// 메인 화면에서 요구하는 형식대로 날짜를 포매팅해 출력하는 메서드입니다.
    func formatStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.string(from: self)
    }
}
