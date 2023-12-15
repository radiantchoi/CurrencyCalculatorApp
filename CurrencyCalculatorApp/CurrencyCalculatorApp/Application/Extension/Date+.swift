//
//  Date+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

extension Date {
    func formatStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.string(from: self)
    }
}
