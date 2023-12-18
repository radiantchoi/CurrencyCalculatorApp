//
//  UIViewController+.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/16/23.
//

import UIKit

extension UIViewController {
    /// OK를 누르면 사라지는 얼럿입니다. 이후 수행할 액션을 지정해줄 수 있습니다.
    func makeOKAlert(title: String, message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .cancel, handler: action)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
