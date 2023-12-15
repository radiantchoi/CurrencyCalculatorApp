//
//  UITextField+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/15/23.
//

import UIKit

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        resignFirstResponder()
    }
}
