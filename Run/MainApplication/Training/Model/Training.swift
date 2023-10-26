//
//  Training.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

final class Training: Hashable, DictionaryConvertible {
    
    static func == (lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id && lhs.userId == rhs.userId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
    }
    
    enum TrainingStatus {
        case start, pause, stop
    }
    
    let id: String
    let userId: String
    var startTime: Date = Date()
    var finishTime: Date = Date()
    var trainingStatus: TrainingStatus = .start
    var coordinates: [[CLLocationCoordinate2D]] = []
    var distance: Double = 0.0
    var time: Double = 0.0
    var temp: Double = 0.0
    var averageTemp: Double = 0.0
    
    init(id: String = UUID().uuidString, userId: String) {
        self.id = id
        self.userId = userId
    }
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let startTime = dictionary["startTime"] as? TimeInterval,
              let finishTime = dictionary["finishTime"] as? TimeInterval,
              let userId = dictionary["userId"] as? String,
              let distance = dictionary["distance"] as? Double,
              let time = dictionary["time"] as? Double,
              let temp = dictionary["temp"] as? Double,
              let averageTemp = dictionary["averageTemp"] as? Double else {
            return nil
        }
        
        self.id = id
        self.startTime = Date(timeIntervalSince1970: startTime)
        self.finishTime = Date(timeIntervalSince1970: finishTime)
        self.userId = userId
        self.distance = distance
        self.time = time
        self.temp = temp
        self.averageTemp = averageTemp
    }
    
    var toDict: [String: Any] {
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["startTime"] = startTime.timeIntervalSince1970
        dict["finishTime"] = finishTime.timeIntervalSince1970
        dict["userId"] = userId
        dict["distance"] = distance
        dict["time"] = time
        dict["temp"] = temp
        dict["averageTemp"] = averageTemp
        
        return dict
    }
}
