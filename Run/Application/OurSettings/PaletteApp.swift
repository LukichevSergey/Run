//
//  PaletteApp.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import UIKit

struct PaletteApp {
    
    //MARK: - Colors
    
    static var black:                      UIColor { return UIColor(hex: "#000000") }  // Черный
    static var white:                      UIColor { return UIColor(hex: "#ffffff") }  // Белый
    static var green:                      UIColor { return UIColor(hex: "#35ff27") }  // Зеленый
    static var lightGreen:                 UIColor { return UIColor(hex: "#9fcd6e") }  // Светло - зеленый
    static var lightOrange:                UIColor { return UIColor(hex: "#fee0c1") }  // Светло - оранжевый
    static var red:                        UIColor { return UIColor(hex: "#fb000e") }  // Красный
    static var yellow:                     UIColor { return UIColor(hex: "#ffff28") }  // Желтый

    //MARK: - Gradients
    
    static let timerBackgroundGradient: () -> CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FFFFFF").cgColor, UIColor(hex: "#d9cae1").cgColor]
        
        return gradientLayer
    }
}
