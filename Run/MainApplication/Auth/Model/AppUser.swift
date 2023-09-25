//
//  AppUser.swift
//  Run
//
//  Created by Лукичев Сергей on 30.08.2023.
//

import Foundation

final class AppUser: Codable {

    private let id: String
    private var name: String
    
    func setName(on name: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.name = name
    }
    
    func getName() -> String {
        logger.log("\(#fileID) -> \(#function)")
        return name
    }
    
    func getId() -> String {
        logger.log("\(#fileID) -> \(#function)")
        return id
    }
    
    internal init(id: String, name: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.id = id
        self.name = name
    }
    
    init?(from dictionary: [String: Any]) {
        logger.log("\(#fileID) -> \(#function)")
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    var toDict: [String: Any] {
        logger.log("\(#fileID) -> \(#function)")
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["name"] = name
        
        return dict
    }
}
    
class Balance: Codable {
    let id: String
    let userId: String
    var currentAmount: Double
    
    internal init(id: String = UUID().uuidString, userId: String, currentAmount: Double = 30) {
        logger.log("\(#fileID) -> \(#function)")
        self.id = id
        self.userId = userId
        self.currentAmount = currentAmount
    }
    
    init?(from dictionary: [String: Any]) {
        logger.log("\(#fileID) -> \(#function)")
        guard let id = dictionary["id"] as? String,
              let userId = dictionary["userId"] as? String,
              let currentAmount = dictionary["currentAmount"] as? Double else {
            return nil
        }
        
        self.id = id
        self.userId = userId
        self.currentAmount = currentAmount
    }
    
    var toDict: [String: Any] {
        logger.log("\(#fileID) -> \(#function)")
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["userId"] = userId
        dict["currentAmount"] = currentAmount
        
        return dict
    }
}

class Sneakers: Codable, Hashable, DictionaryConvertible {
    
    static func == (lhs: Sneakers, rhs: Sneakers) -> Bool {
        return lhs.id == rhs.id && lhs.userId == rhs.userId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
    }
    
    let id: String
    let userId: String
    let level: Int
    let trainingsCount: Int
    let distance: Double
    let money: Double
    let condition: Double
    
    internal init(id: String = UUID().uuidString,
                  userId: String,
                  level: Int = 1,
                  trainingsCount: Int = 0,
                  distance: Double = 0,
                  money: Double = 0,
                  condition: Double = 100) {
        logger.log("\(#fileID) -> \(#function)")
        self.id = id
        self.userId = userId
        self.level = level
        self.trainingsCount = trainingsCount
        self.distance = distance
        self.money = money
        self.condition = condition
    }
    
    required init?(from dictionary: [String: Any]) {
        logger.log("\(#fileID) -> \(#function)")
        guard let id = dictionary["id"] as? String,
              let userId = dictionary["userId"] as? String,
              let level = dictionary["level"] as? Int,
              let trainingsCount = dictionary["trainingsCount"] as? Int,
              let distance = dictionary["distance"] as? Double,
              let money = dictionary["money"] as? Double,
              let condition = dictionary["condition"] as? Double else {
            return nil
        }
        
        self.id = id
        self.userId = userId
        self.level = level
        self.trainingsCount = trainingsCount
        self.distance = distance
        self.money = money
        self.condition = condition
    }
    
    var toDict: [String: Any] {
        logger.log("\(#fileID) -> \(#function)")
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["userId"] = userId
        dict["level"] = level
        dict["trainingsCount"] = trainingsCount
        dict["distance"] = distance
        dict["money"] = money
        dict["condition"] = condition
        
        return dict
    }
}
