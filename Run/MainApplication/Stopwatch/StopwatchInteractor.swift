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
        trainingManager.helperValueTemp.resetAll()
        
    }
    
    func roundResult() -> CircleViewModel {
        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
            
        }
        
        let timeCircles = timer.elapsedTime - trainingManager.helperValueTemp.circleTimeAll
        let circleDistance = distance - trainingManager.helperValueTemp.circleDistanceAll
        trainingManager.helperValueTemp.saveCircleHelper(circle: 1, circleDistance: circleDistance, circleTime: timeCircles)
                
        return CircleViewModel(circle: "\(Tx.CircleTableResult.circle) \(trainingManager.helperValueTemp.circleCount)",
                               distance: "\(String(format: "%.2f", circleDistance / 1000))",
                               time: "\(timeCircles.toMinutesAndSeconds())")
    }
    
    func getTimerData() -> TimerViewModel {

        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
            
        }
        
        let avgerageTemp = trainingManager.getAverageTempModel(distance: distance, time: timer.elapsedTime)
        let tempOneKillomert = trainingManager.getTempModel(distance: distance, time: timer.elapsedTime)
        
        trainingManager.helperValueTemp.saveCurrentDistance(distance: String(format: "%.2f", distance / 1000))
                        
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
