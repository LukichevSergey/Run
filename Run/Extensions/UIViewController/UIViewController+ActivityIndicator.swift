//
//  UIViewController+ActivityIndicator.swift
//  Run
//
//  Created by Лукичев Сергей on 03.09.2023.
//

import UIKit

extension UIViewController {
    func getActivityIndicatorView() -> UIActivityIndicatorView? {
        return view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = PaletteApp.lightGreen
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        if let view = getActivityIndicatorView() {
            view.stopAnimating()
            view.removeFromSuperview()
        }
    }
}
