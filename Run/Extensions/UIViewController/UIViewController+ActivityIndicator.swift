//
//  UIViewController+ActivityIndicator.swift
//  Run
//
//  Created by Лукичев Сергей on 03.09.2023.
//

import UIKit

extension UIViewController {
    func getActivityIndicatorView() -> ActivityIndicatorInterface? {
        return view.subviews.first(where: { $0 is ActivityIndicatorInterface }) as? ActivityIndicatorInterface
    }
    
    func showActivityIndicator() {
        let activityView: ActivityIndicatorInterface = ActivityIndicatorView(frame: view.bounds)
        view.addSubview(activityView)
        activityView.startAnimation()
    }
    
    func removeActivityIndicator() {
        if let view = getActivityIndicatorView() {
            view.stopAnimation()
            view.removeFromSuperview()
        }
    }
}
