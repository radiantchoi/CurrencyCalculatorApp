//
//  URL+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

extension URL {
    /// 버전에 따라 다른 내부 메서드를 적용해, URL에 Path를 더하는 메서드입니다.
    func appendingPath(_ component: String) -> URL {
        if #available(iOS 16.0, *) {
            return appending(path: component)
        } else {
            return appendingPathComponent(component)
        }
    }
}
