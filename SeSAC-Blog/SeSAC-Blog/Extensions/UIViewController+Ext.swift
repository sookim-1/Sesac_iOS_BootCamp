//
//  UIViewController+Ext.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import UIKit

extension UIViewController {
    func bindingTextField(_ viewModelProperty: Observable<String>, _ textField: UITextField) {
        viewModelProperty.bind { text in
            textField.text = text
        }
    }

    func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: text)
    }

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
