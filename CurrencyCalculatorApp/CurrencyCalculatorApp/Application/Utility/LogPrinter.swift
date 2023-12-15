//
//  LogPrinter.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/16/23.
//

import Foundation

enum LogPrinter {
    static func print(_ items: Any, file: String = #fileID, function: String = #function, line: Int = #line) {
        #if DEBUG
        Swift.print()
        Swift.print("🟩 Log at \(file)")
        Swift.print("🟩 Function: \(function), line: \(line)")
        Swift.print("🟩")
        Swift.print("🟩", items)
        Swift.print()
        #endif
    }
    
    static func printArray(_ array: [Any], file: String = #fileID, function: String = #function, line: Int = #line) {
        #if DEBUG
        Swift.print()
        Swift.print("🟩 Log at \(file)")
        Swift.print("🟩 Function: \(function), line: \(line)")
        Swift.print("🟩")
        for item in array {
            Swift.print("🟩", item)
        }
        Swift.print()
        #endif
    }
}
