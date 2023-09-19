//
//  TrainingManager.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

protocol UpdateDataTempDelegate {
    func сurrentDistance(distance: String)
    func сurrentAverageTemp(average: String)
    func сurrentTemp(temp: String)
    func tempHelper(time: Double, traveled: Double, iteration: Int)
}

final class TrainingManager {
    
    private var trainings: [Training] = []
    var coordinates: [CLLocationCoordinate2D] = []
    
    var locationManager = LocationManager()
    
    var currentTraining: Training?
    var delegate: UpdateDataTempDelegate?
    
    var trainingStatus: Training.TrainingStatus {
        return currentTraining?.trainingStatus ?? .stop
    }
    
    func setTrainingStatus(on status: Training.TrainingStatus) {
        currentTraining?.trainingStatus = status
    }
    
    func createTraining() {
        guard currentTraining == nil else { return }
        currentTraining = Training()
    }
    
    func updateTraining(with coordinates: [CLLocationCoordinate2D]) {
        currentTraining?.coordinates.append(coordinates)
    }
    
    func getCurrentTrainingCoordinates() -> [[CLLocationCoordinate2D]] {
        return currentTraining?.coordinates ?? []
    }
    
    func stopTraining() {
        currentTraining?.finishTime = Date()
        guard let currentTraining else { return }
        trainings.append(currentTraining)
        self.currentTraining = nil
    }
    
    //MARK: - method distance
    func getDistance() -> Double {
        var coordinates = getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        
        delegate?.сurrentDistance(distance: String(format: "%.2f", distance / 1000))
        
        return distance
    }
    
    //MARK: - method average temp
    func getAverageTempModel(distance: Double, time: Double ) -> String {
        let avgtemp = (time / distance) * 1000
        
        delegate?.сurrentAverageTemp(average: avgtemp.toMinutesAndSeconds())
        
        return avgtemp.toMinutesAndSeconds()
    }
    //MARK: - method temp
    func getTempModel(distance: Double, time: Double, kmTraveled: Double, kmIteration: Int, timeAllKM: Double) -> String {
        if (distance - kmTraveled) > 10 {
            if Int(distance / 1000) > kmIteration {
                
                delegate?.tempHelper(time: time, traveled: distance, iteration: Int(distance) / 1000)
                
                let length = 1000 / (distance - kmTraveled)
                let tempSec = (time - timeAllKM) * length
                
                delegate?.сurrentTemp(temp: tempSec.toMinutesAndSeconds())
                
                return tempSec.toMinutesAndSeconds()
            } else {
                let length = 1000 / (distance - kmTraveled)
                let tempSec = (time - timeAllKM) * length
                delegate?.сurrentTemp(temp: tempSec.toMinutesAndSeconds())

                return tempSec.toMinutesAndSeconds()
            }
        } else {
            delegate?.сurrentTemp(temp: "0:00")
            return "0:00"
        }
    }
}
