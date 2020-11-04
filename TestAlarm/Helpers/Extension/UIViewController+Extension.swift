//
//  UIViewController+Extension.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import UIKit

extension UIViewController {
    func showAlertMessage(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: handler)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
