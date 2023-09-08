//
//  AppUser.swift
//  Run
//
//  Created by Лукичев Сергей on 30.08.2023.
//

import Foundation

class AppUser: Codable {

    let id: String
    var name: String
    
    internal init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    var toDict: [String: Any] {
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
        self.id = id
        self.userId = userId
        self.currentAmount = currentAmount
    }
    
    init?(from dictionary: [String: Any]) {
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
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["userId"] = userId
        dict["currentAmount"] = currentAmount
        
        return dict
    }
}

class Sneakers: Codable {
    
    let id: String
    let userId: String
    var mileage: Double
    
    internal init(id: String = UUID().uuidString, userId: String, mileage: Double = 0) {
        self.id = id
        self.userId = userId
        self.mileage = mileage
    }
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let userId = dictionary["userId"] as? String,
              let mileage = dictionary["mileage"] as? Double else {
            return nil
        }
        
        self.id = id
        self.userId = userId
        self.mileage = mileage
    }
    
    var toDict: [String: Any] {
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["userId"] = userId
        dict["mileage"] = mileage
        
        return dict
    }
}

