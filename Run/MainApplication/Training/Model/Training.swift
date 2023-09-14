//
//  Training.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

final class Training {
    
    enum TrainingStatus {
        case start, pause, stop
    }
    
    let id: String
    let userId: String
    let startTime: Date = Date()
    var finishTime: Date? = nil
    var trainingStatus: TrainingStatus = .start
    var coordinates: [[CLLocationCoordinate2D]] = []
    var distance: Double = 0
    var time: Double = 0
    var temp: String = ""
    var averageTemp: String = ""
    
    init(id: String = UUID().uuidString, userId: String) {
        self.id = id
        self.userId = userId
    }
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let userId = dictionary["userId"] as? String,
              let distance = dictionary["distance"] as? Double,
              let time = dictionary["time"] as? Double,
              let temp = dictionary["temp"] as? String,
              let averageTemp = dictionary["averageTemp"] as? String else {
            return nil
        }
        
        self.id = id
        self.userId = userId
        self.distance = distance
        self.time = time
        self.temp = temp
        self.averageTemp = averageTemp
    }
    
    var toDict: [String: Any] {
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["userId"] = userId
        dict["distance"] = distance
        dict["time"] = time
        dict["temp"] = temp
        dict["averageTemp"] = averageTemp
        
        return dict
    }
}
