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
    
    var helperValueTemp = HelperValueTempsModel()
    
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
    //MARK: - method average temp
    func getAverageTempModel(distance: Double, time: Double ) -> String {
        let avgtemp = (time / distance) * 1000
        helperValueTemp.saveCurrentAverageTemp(average: avgtemp.toMinutesAndSeconds())
        return avgtemp.toMinutesAndSeconds()
    }
    //MARK: - method temp
    func getTempModel(distance: Double, time: Double) -> String {
        if (distance - helperValueTemp.kmTraveled) > 10 {
            if Int(distance / 1000) > helperValueTemp.kmIteration {
                
                helperValueTemp.saveTempHelper(time: time, traveled: distance, iteration: Int(distance) / 1000)
                
                let length = 1000 / (distance - helperValueTemp.kmTraveled)
                let tempSec = (time - helperValueTemp.timeAllKM) * length
                helperValueTemp.saveCurrentTemp(temp: tempSec.toMinutesAndSeconds())
                
                return tempSec.toMinutesAndSeconds()
            } else {
                let length = 1000 / (distance - helperValueTemp.kmTraveled)
                let tempSec = (time - helperValueTemp.timeAllKM) * length
                helperValueTemp.saveCurrentTemp(temp: tempSec.toMinutesAndSeconds())
                
                return tempSec.toMinutesAndSeconds()
            }
        } else {
            helperValueTemp.saveCurrentTemp(temp: "0:00")
            return "0:00"
        }
    }
}
