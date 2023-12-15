//
//  UIViewController+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/16/23.
//

import UIKit

extension UIViewController {
    // OK를 누르면 소멸하고 아무것도 하지 않는 얼럿입니다.
    func makeOKAlert(title: String, message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .cancel, handler: action)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
