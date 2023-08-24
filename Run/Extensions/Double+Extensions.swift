//
//  Double+Extensions.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import Foundation

extension Double {
    func formatTime(format: String = "%02d:%02d:%02d") -> String {
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((self * 100).truncatingRemainder(dividingBy: 100))
        return String(format: format, minutes, seconds, milliseconds)
    }
}
