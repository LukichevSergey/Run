//
//  UIViewController+Alert.swift
//  Run
//
//  Created by Лукичев Сергей on 03.09.2023.
//

import UIKit

extension UIViewController {
    func showAlert(with text: String) {
        let alertController = UIAlertController(title: Tx.System.error, message: text, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: Tx.System.close, style: .default, handler: nil)
        alertController.addAction(closeAction)

        present(alertController, animated: true, completion: nil)
    }
}
