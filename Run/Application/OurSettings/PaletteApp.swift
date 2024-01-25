//
//  PaletteApp.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//
// swiftlint: disable colon
import UIKit

struct PaletteApp {
    // MARK: - Colors
    static var black:                      UIColor { return UIColor(hex: "#000000") }  // Черный
    static var white:                      UIColor { return UIColor(hex: "#ffffff") }  // Белый
    static var green:                      UIColor { return UIColor(hex: "#35ff27") }  // Зеленый
    static var lightGreen:                 UIColor { return UIColor(hex: "#9fcd6e") }  // Светло - зеленый
    static var darkGreen:                  UIColor { return UIColor(hex: "#70A754") }  // Темно - зеленый
    static var lightOrange:                UIColor { return UIColor(hex: "#fee0c1") }  // Светло - оранжевый
    static var lightblue:                  UIColor { return UIColor(hex: "#A3D5EC") }  // Светло - синий
    static var darkblue:                   UIColor { return UIColor(hex: "#1D5F8C") }  // Темно - синий
    static var darkbOrange:                UIColor { return UIColor(hex: "#A35209") }  // Темно - оранжевый
    static var red:                        UIColor { return UIColor(hex: "#fb000e") }  // Красный
    static var yellow:                     UIColor { return UIColor(hex: "#ffff28") }  // Желтый
    static var grey:                       UIColor { return UIColor(hex: "#D9D9D9") }  // Серый

    // MARK: - Gradients
    static let timerBackgroundGradient: () -> CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FFFFFF").cgColor, UIColor(hex: "#d9cae1").cgColor]
        return gradientLayer
    }
}
// swiftlint: enable colon
