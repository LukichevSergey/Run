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
    
    func savingCircleHelper(circle: Int, circleDistance: Double, circleTime: Double) {
        circleCount += circle
        circleTimeAll += circleTime
        circleDistanceAll += circleDistance
    }
    
    func savingCurrentAverageTemp(average: String) {
        currentAverageTemp = average
    }
    
    func savingCurrentDistance(distance: String) {
        currentDistance = distance
    }
    
    func savingCurrentTemp(temp: String) {
        currentTemp = temp
    }
    
    func savingTempHelper(time: Double, traveled: Double, iteration: Int) {
        timeAllKM = time
        kmTraveled = traveled
        kmIteration = iteration
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
