//
//  TrainingManager.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

final class TrainingManager {
    
    private var trainings: [Training] = []
    
    var helperValueTemp = HelperValueTepms()
    
    var currentTraining: Training?
    
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
    
    func getAverageTempModel(dist: Double, time: Double ) -> String {
            let avgtemp = (time / dist) * 1000
            let formatedTime = avgtemp.toMinutesAndSeconds()
            
            return "\(formatedTime)"
        }
    
    func getTempModel(distance: Double, time: Double) -> String {
        
        if Int(distance / 1000) > helperValueTemp.kmIteration {
            
            helperValueTemp.kmIteration = Int(distance) / 1000
            let kmTraveled = distance
            helperValueTemp.timeAllKM = time
            helperValueTemp.kmTraveled = distance
            let length = 1000 / (distance - kmTraveled)
            let tempSec = (time - helperValueTemp.timeAllKM) * length
            
            return tempSec.toMinutesAndSeconds()
        } else {
            let length = 1000 / (distance - helperValueTemp.kmTraveled)
            let tempSec = (time - helperValueTemp.timeAllKM) * length
            
            return tempSec.toMinutesAndSeconds()
        }
    }
}
