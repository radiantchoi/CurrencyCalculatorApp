//
//  UITextField+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/15/23.
//

import UIKit

extension UITextField {
    /// 키보드에 Done 버튼을 추가해주는 메서드입니다.
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        toolbar.items = [
            doneButton
        ]
        toolbar.sizeToFit()
        
        inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        resignFirstResponder()
    }
}
