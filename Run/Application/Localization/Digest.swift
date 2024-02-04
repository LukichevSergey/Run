//
//  Digest.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//
// swiftlint: disable localized_string

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
        static let editProfile = NSLocalizedString("Profile.editProfile", comment: "Редактировать профиль")
        static let currency = NSLocalizedString("Profile.currency", comment: "трен")
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
        static let allTime = NSLocalizedString("Training.allTime", comment: "Общее время")
        static let kilometr = NSLocalizedString("Training.kilometr", comment: "Километр")
        static let target = NSLocalizedString("Training.target", comment: "Цель")
        static let cityNotFound = NSLocalizedString("Training.cityNotFound", comment: "Город не найден")
        static let kilometerLayout = NSLocalizedString("Training.kilometerLayout", comment: "Раскладка")
        static let dateNotAvailable = NSLocalizedString("Training.dateNotAvailable", comment: "Дата отсутствует")
        static let delete = NSLocalizedString("Training.delete", comment: "Удалить")
    }
    enum CircleTableResult {
        static let circle = NSLocalizedString("CircleTableResult.circle", comment: "Круг")
        static let distance = NSLocalizedString("CircleTableResult.distance", comment: "Дистанция")
        static let time = NSLocalizedString("CircleTableResult.time", comment: "Время")
        static let end = NSLocalizedString("CircleTableResult.end", comment: "Конец")
    }
    enum Charts {
        static let statistics = NSLocalizedString("Charts.statistics", comment: "Статистика")
        static let week = NSLocalizedString("Charts.week", comment: "Неделя")
        static let month = NSLocalizedString("Charts.month", comment: "Месяц")
        static let year = NSLocalizedString("Charts.year", comment: "Год")
        static let distance = NSLocalizedString("Charts.distance", comment: "Расстояние")
        static let Kkal = NSLocalizedString("Charts.Kkal", comment: "Ккал")
    }
    enum TimePeriods {
        static let hour = NSLocalizedString("TimePeriods.hour", comment: "ч")
        static let minute = NSLocalizedString("TimePeriods.minute", comment: "мин")
        static let year = NSLocalizedString("TimePeriods.year", comment: "г.")
    }
}
// swiftlint: enable localized_string
