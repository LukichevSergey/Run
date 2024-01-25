//
//  ActivityIndicatorView.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import UIKit

protocol ActivityIndicatorInterface: UIView {
    func startAnimation()
    func stopAnimation()
}

final class ActivityIndicatorView: UIView {
    private lazy var dimmingView: UIView = {
        let dimmingView = UIView(frame: bounds)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimmingView.alpha = 0
        return dimmingView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = center
        activityIndicator.color = PaletteApp.lightGreen
        return activityIndicator
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        addSubview(dimmingView)
        addSubview(activityIndicator)
    }
}

extension ActivityIndicatorView: ActivityIndicatorInterface {
    func startAnimation() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
    }
    func stopAnimation() {
        activityIndicator.stopAnimating()
    }
}
