//
//  Training.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

final class Training: Hashable {
    
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
    let startTime: Date = Date()
    var finishTime: Date? = nil
    var trainingStatus: TrainingStatus = .start
    var coordinates: [[CLLocationCoordinate2D]] = []
    
    init(startTime: Date = Date(),
                  finishTime: Date? = nil,
                  trainingStatus: TrainingStatus = .start,
                  coordinates: [[CLLocationCoordinate2D]] = []) {
        logger.log("\(#fileID) -> \(#function)")
        self.startTime = startTime
        self.finishTime = finishTime
        self.trainingStatus = trainingStatus
        self.coordinates = coordinates
    var distance: String = ""
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
              let distance = dictionary["distance"] as? String,
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
