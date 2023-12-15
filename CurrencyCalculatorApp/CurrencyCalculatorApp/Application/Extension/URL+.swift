//
//  URL+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

extension URL {
    func appendingPath(_ component: String) -> URL {
        if #available(iOS 16.0, *) {
            return appending(path: component)
        } else {
            return appendingPathComponent(component)
        }
    }
}
