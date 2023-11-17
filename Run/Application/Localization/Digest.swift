//
//  Digest.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import Foundation

enum Tx {
    enum System {
        static let error = NSLocalizedString("System.error", comment: "Ошибка")
        static let close  = NSLocalizedString("System.close", comment: "Закрыть")
    }
    
    enum Timer {
        static let title = NSLocalizedString("Timer.title", comment: "Секундомер")
        static let subtitle = NSLocalizedString("Timer.subtitle", comment: "Время")
        static let kilometr = NSLocalizedString("Timer.kilometr", comment: "КМ")
        static let temp = NSLocalizedString("Timer.temp", comment: "Темп")
        static let averageTemp = NSLocalizedString("Timer.averageTemp", comment: "Сред.Темп")
    }
    
    enum Auth {
        static let signIn = NSLocalizedString("Auth.signIn", comment: "Войти")
        static let signUp = NSLocalizedString("Auth.signUp", comment: "Зарегистрироваться")
        static let name = NSLocalizedString("Auth.name", comment: "Имя")
    }
    
    enum Profile {
        static let title = NSLocalizedString("Profile.title", comment: "Профиль")
        static let exit = NSLocalizedString("Profile.exit", comment: "Выход")

        static func getBalance(balance: Double) -> String {
            let formatString = NSLocalizedString("Profile.balance", comment: "Баланс: %.2f $")
            return String.init(format: formatString, balance)
        }
    }
    
    enum Training {
        static let title = NSLocalizedString("Training.title", comment: "Тренировки")
        static let run = NSLocalizedString("Training.run", comment: "Бег")
        static let allTraining = NSLocalizedString("Training.allTtaining", comment: "Все тренировки")
        static let information = NSLocalizedString("Training.information", comment: "Сведения")
        static let activity = NSLocalizedString("Training.activity", comment: "Активность")
        static let allActivity = NSLocalizedString("Training.allActivity", comment: "Вся активность")
        static let step = NSLocalizedString("Training.step", comment: "ШАГИ")
        static let kilomertes = NSLocalizedString("Training.kilometres", comment: "КИЛОМЕТРЫ")
        static let willBeCharged = NSLocalizedString("Training.willBeCharged", comment: "Будет начислено")
        static let totalTime = NSLocalizedString("Training.totalTime", comment: "Всего")
        static let allAverageTime = NSLocalizedString("Training.allAverageTime", comment: "В cреднем")
        static let graphics = NSLocalizedString("Training.graphics", comment: "Графики")
    }
    
    enum CircleTableResult {
        static let circle = NSLocalizedString("CircleTableResult.circle", comment: "Круг")
        static let distance = NSLocalizedString("CircleTableResult.distance", comment: "Дистанция")
        static let time = NSLocalizedString("CircleTableResult.time", comment: "Время")
    }
}
