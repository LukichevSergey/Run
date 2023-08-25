//
//  PaletteApp.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import UIKit

struct PaletteApp {
    
    //MARK: - Colors
    
    static var white:                      UIColor { return UIColor(hex: "#FFFFFF") }  // белый
    static var black:                      UIColor { return UIColor(hex: "#000000") }  // черный
    static var gray:                       UIColor { return UIColor(hex: "#EAEFF2") }  // Cерый
    static var darkGray:                   UIColor { return UIColor(hex: "#8D8D8D") }  // Темносерый

    //MARK: - Gradients
    
    static let timerBackgroundGradient: () -> CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FFFFFF").cgColor, UIColor(hex: "#d9cae1").cgColor]
        
        return gradientLayer
    }
}
