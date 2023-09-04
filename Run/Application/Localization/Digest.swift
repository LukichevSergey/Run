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
    }
    
    enum Training {
        static let title = NSLocalizedString("Training.title", comment: "Тренировки")
    }
}
