//
//  StopwatchInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation
import CoreLocation

// MARK: Protocol - StopwatchPresenterToInteractorProtocol (Presenter -> Interactor)
protocol StopwatchPresenterToInteractorProtocol: AnyObject {
    
    var timer: TimerManager { get }
    
    func startTimer()
    func stopTimer()
    func resetTimer()
    func getTimerData() -> TimerViewModel
    func requestAuthorization()
    func roundResult() -> CircleViewModel
}

final class StopwatchInteractor {
    
    private let timerManager = TimerManager()
    private let locationManager = LocationManager()
    private let trainingManager = TrainingManager()
    
    private var coordinates: [CLLocationCoordinate2D] = []
    
    private var kmIteration = 0
    private var kmTraveled: Double = 0
    private var timeAllKM: Double = 0
    private var circle = 0
    private var circleTimeAll: Double = 0
    private var circleDistanceAll: Double = 0

    // MARK: Properties
    weak var presenter: StopwatchInteractorToPresenterProtocol!
    
    init() {
        locationManager.delegate = self
    }
}

// MARK: Extension - StopwatchPresenterToInteractorProtocol
extension StopwatchInteractor: StopwatchPresenterToInteractorProtocol {
    var timer: TimerManager {
        return timerManager
    }
    
    func stopTimer() {
        timerManager.stopTimer()
        locationManager.stopUpdatingLocation()
        trainingManager.setTrainingStatus(on: .pause)
        trainingManager.updateTraining(with: coordinates)
        coordinates = []
    }
    
    func startTimer() {
        timerManager.startTimer()
        locationManager.startUpdatingLocation()
        trainingManager.createTraining()
        trainingManager.setTrainingStatus(on: .start)
        
    }
    
    func resetTimer() {
        timerManager.resetTimer()
        locationManager.stopUpdatingLocation()
        trainingManager.setTrainingStatus(on: .stop)
        trainingManager.updateTraining(with: coordinates)
        trainingManager.stopTraining()
        coordinates = []
        kmIteration = 0
        kmTraveled = 0
        timeAllKM = 0
        circle = 0
        circleTimeAll = 0
        circleDistanceAll = 0
    }
    
    func roundResult() -> CircleViewModel {
        
        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        circle += 1
        let timeCircles = timer.elapsedTime - circleTimeAll
        circleTimeAll += timeCircles
        
        let circleDistance = distance - circleDistanceAll
        circleDistanceAll += circleDistance
        
        return CircleViewModel(circle: "Круг \(circle)", distance: "\(String(format: "%.2f", circleDistance / 1000))", time: "\(timeCircles.toMinutesAndSeconds())")
    }
    
    func getTimerData() -> TimerViewModel {
        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        
        var avgerageTemp: String {
            let avgtemp = (timer.elapsedTime / distance) * 1000
            let formatedTime = avgtemp.toMinutesAndSeconds()
            
            return "\(formatedTime)"
        }
        
        var tempOneKillomert: String {
            if Int(distance / 1000) > kmIteration {
                kmIteration += 1
                kmTraveled = distance
                timeAllKM = timer.elapsedTime
                let length = 1000 / (distance - kmTraveled)
                let tempSec = (timer.elapsedTime - timeAllKM) * length
                
                return tempSec.toMinutesAndSeconds()
            } else {
                let length = 1000 / (distance - kmTraveled)
                let tempSec = (timer.elapsedTime - timeAllKM) * length
                
                return tempSec.toMinutesAndSeconds()
            }
        }
                
        return TimerViewModel(kilometrModel: .init(data: "\(String(format: "%.2f", distance / 1000))", description: Tx.Timer.kilometr),
                              tempModel: .init(data: "\(tempOneKillomert)", description: Tx.Timer.temp),
                              averageTempModel: .init(data: "\(avgerageTemp)", description: Tx.Timer.averageTemp))
    }
    
    func requestAuthorization() {
        locationManager.requestAuthorization()
    }
}

extension StopwatchInteractor: LocationManagerDelegate {
    func didUpdateUserLocation(_ location: CLLocation) {
        guard trainingManager.trainingStatus == .start else { return }
        coordinates.append(location.coordinate)
        presenter.userLocationIsUpdated()
    }
}
