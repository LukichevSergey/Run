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
        circleCount += circle
        circleTimeAll += circleTime
        circleDistanceAll += circleDistance
    }
   
    func resetAll() {
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

extension HelperValueTempsModel: UpdateDataTempDelegate {
    
    func saveCurrentAverageTemp(average: String) {
        currentAverageTemp = average
    }
    
    func saveCurrentDistance(distance: String) {
        currentDistance = distance
    }
    
    func saveCurrentTemp(temp: String) {
        currentTemp = temp
    }
    
    func saveTempHelper(time: Double, traveled: Double, iteration: Int) {
        timeAllKM = time
        kmTraveled = traveled
        kmIteration = iteration
    }
}
