//
//  TrainingManager.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

// MARK: Protocol Training -> HelperValueTemp
protocol UpdateDataTempDelegate {
    func currentDistanceChanged(distance: String)
    func сurrentAverageTempChanged(average: String)
    func сurrentTempChanged(temp: String)
    func currentResultsСhanged(time: Double, traveled: Double, iteration: Int)
}

final class TrainingManager {
    
    private var user: AppUser
    private var trainings: [Training] = []
    var coordinates: [CLLocationCoordinate2D] = []

    private var currentTime = 0.0
    private var currentDistance = ""
    private var currentTemp = ""
    private var currentAverage = ""
    
    var locationManager = LocationManager()
    init(user: AppUser) {
        self.user = user
    }

    var currentTraining: Training?
    var delegate: UpdateDataTempDelegate?
    
    func saveLastDataTrainingChange(average: String, distance: String, temp: String, time: Double) {
        currentAverage = average
        currentDistance = distance
        currentTemp = temp
        currentTime = time
    }
    
    func currentLastAverageTempChange(average: String) {
        currentAverage = average
    }
    
    var trainingStatus: Training.TrainingStatus {
        logger.log("\(#fileID) -> \(#function)")
        return currentTraining?.trainingStatus ?? .stop
    }
    
    func setTrainingStatus(on status: Training.TrainingStatus) {
        logger.log("\(#fileID) -> \(#function)")
        currentTraining?.trainingStatus = status
    }
    
    func createTraining() {
        logger.log("\(#fileID) -> \(#function)")
        guard currentTraining == nil else { return }
        currentTraining = Training(userId: user.getId())
    }
    
    func updateTraining(with coordinates: [CLLocationCoordinate2D]) {
        logger.log("\(#fileID) -> \(#function)")
        currentTraining?.coordinates.append(coordinates)
    }
    
    func getCurrentTrainingCoordinates() -> [[CLLocationCoordinate2D]] {
        logger.log("\(#fileID) -> \(#function)")
        return currentTraining?.coordinates ?? []
    }
    
    func stopTraining() {
        logger.log("\(#fileID) -> \(#function)")
        currentTraining?.finishTime = Date()
        currentTraining?.distance = currentDistance
        currentTraining?.time = currentTime
        currentTraining?.temp = currentTemp
        currentTraining?.averageTemp = currentAverage
        guard let currentTraining else { return }
        trainings.append(currentTraining)
        self.currentTraining = nil
    }
    
    //MARK: - method distance
    func getDistance() -> Double {
        logger.log("\(#fileID) -> \(#function)")
        var coordinates = getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        
        delegate?.currentDistanceChanged(distance: String(format: "%.2f", distance / 1000))
        
        return distance
    }
    
    //MARK: - method average temp
    func getAverageTempModel(distance: Double, time: Double ) -> String {
        logger.log("\(#fileID) -> \(#function)")
        let avgtemp = (time / distance) * 1000
        
        delegate?.сurrentAverageTempChanged(average: avgtemp.toMinutesAndSeconds())
        
        return avgtemp.toMinutesAndSeconds()
    func getLastTraining() -> Training? {
        return trainings.last
    }
    //MARK: - method temp
    func getTempModel(distance: Double, time: Double, kmTraveled: Double, kmIteration: Int, timeAllKM: Double) -> String {
        logger.log("\(#fileID) -> \(#function)")
        if (distance - kmTraveled) > 10 {
            if Int(distance / 1000) > kmIteration {
                
                delegate?.currentResultsСhanged(time: time, traveled: distance, iteration: Int(distance) / 1000)
                
                let length = 1000 / (distance - kmTraveled)
                let tempSec = (time - timeAllKM) * length
                
                delegate?.сurrentTempChanged(temp: tempSec.toMinutesAndSeconds())
                
                return tempSec.toMinutesAndSeconds()
        
        //MARK: - method average temp
        func getAverageTempModel(distance: Double, time: Double ) -> String {
            let avgtemp = (time / distance) * 1000
            
            delegate?.сurrentAverageTempChanged(average: avgtemp.toMinutesAndSeconds())
            
            return avgtemp.toMinutesAndSeconds()
        }
        //MARK: - method temp
        func getTempModel(distance: Double, time: Double, kmTraveled: Double, kmIteration: Int, timeAllKM: Double) -> String {
            if (distance - kmTraveled) > 10 {
                if Int(distance / 1000) > kmIteration {
                    
                    delegate?.currentResultsСhanged(time: time, traveled: distance, iteration: Int(distance) / 1000)
                    
                    let length = 1000 / (distance - kmTraveled)
                    let tempSec = (time - timeAllKM) * length
                    
                    delegate?.сurrentTempChanged(temp: tempSec.toMinutesAndSeconds())
                    
                    return tempSec.toMinutesAndSeconds()
                } else {
                    let length = 1000 / (distance - kmTraveled)
                    let tempSec = (time - timeAllKM) * length
                    
                    delegate?.сurrentTempChanged(temp: tempSec.toMinutesAndSeconds())
                    
                    return tempSec.toMinutesAndSeconds()
                }
            } else {
                
                delegate?.сurrentTempChanged(temp: "0:00")
                
                return "0:00"
            }
        }
    }
