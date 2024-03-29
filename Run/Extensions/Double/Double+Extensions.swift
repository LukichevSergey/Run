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

extension Double {
    // возвращает строку с минутой и секундой.если не число или бесконечность или 0< выдает default "0:00"
    func toMinutesAndSeconds() -> String {
        if self.isInfinite || self.isNaN {
            return "0:00"
        }
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        if minutes < 0 && seconds < 0 {
            return "0:00"
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

extension Double {
    func toHourAndMin(format: String = "%d \(Tx.TimePeriods.hour) %02d \(Tx.TimePeriods.minute)") -> String {
        let hours = Int(self / 3600)
        let minutes = Int(self / 60)
        return String(format: format, hours, minutes)
    }
}

extension Double {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
