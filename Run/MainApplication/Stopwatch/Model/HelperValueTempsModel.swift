//
//  testtest.swift
//  Run
//
//  Created by Evgenii Kutasov on 13.09.2023.
//

import Foundation

final class HelperValueTempsModel {
    var kmIteration: Int = 0
    var timeAllKM: Double = 0
    var kmTraveled: Double = 0
    var circleCount = 0
    var circleTimeAll: Double = 0
    var circleDistanceAll: Double = 0
    var currentTemp = ""
    var currentAverageTemp = ""
    var currentDistance = ""
    
    func saveCircleHelper(circle: Int, circleDistance: Double, circleTime: Double) {
        logger.log("\(#fileID) -> \(#function)")
        circleCount += circle
        circleTimeAll += circleTime
        circleDistanceAll += circleDistance
    }
    
    func saveCurrentAverageTemp(average: String) {
        logger.log("\(#fileID) -> \(#function)")
        currentAverageTemp = average
    }
    
    func saveCurrentDistance(distance: String) {
        logger.log("\(#fileID) -> \(#function)")
        currentDistance = distance
    }
    
    func saveCurrentTemp(temp: String) {
        logger.log("\(#fileID) -> \(#function)")
        currentTemp = temp
    }
    
    func saveTempHelper(time: Double, traveled: Double, iteration: Int) {
        logger.log("\(#fileID) -> \(#function)")
        timeAllKM = time
        kmTraveled = traveled
        kmIteration = iteration
    }
   
    func resetAll() {
        logger.log("\(#fileID) -> \(#function)")
        kmIteration = 0
        timeAllKM = 0
        kmTraveled = 0
        circleCount = 0
        circleTimeAll = 0
        circleDistanceAll = 0
        currentTemp = ""
        currentAverageTemp = ""
        currentDistance = ""
    }
}
