//
//  PaletteApp.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import UIKit

struct PaletteApp {
    
    //MARK: - Colors
    
    static var black:                      UIColor { return UIColor(hex: "#000000") }  // черный
    static var green:                      UIColor { return UIColor(hex: "#35ff27") }  // Зеленый
    static var red:                        UIColor { return UIColor(hex: "#fb000e") }  // Красный
    static var yellow:                     UIColor { return UIColor(hex: "#ffff28") }  // Желтый

    //MARK: - Gradients
    
    static let timerBackgroundGradient: () -> CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FFFFFF").cgColor, UIColor(hex: "#d9cae1").cgColor]
        
        return gradientLayer
    }
}
