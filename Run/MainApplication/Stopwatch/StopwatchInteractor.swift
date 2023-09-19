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
    private let helperValueTemp = HelperValueTempsModel()
        
    // MARK: Properties
    weak var presenter: StopwatchInteractorToPresenterProtocol!
    
    init() {
        locationManager.delegate = self
        trainingManager.delegate = self
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
        trainingManager.updateTraining(with: trainingManager.coordinates)
        trainingManager.coordinates = []
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
        trainingManager.updateTraining(with: trainingManager.coordinates)
        trainingManager.stopTraining()
        trainingManager.coordinates = []
        helperValueTemp.resetAll()
    }
    
    func roundResult() -> CircleViewModel {
        let distance = trainingManager.getDistance()
        let timeCircles = timer.elapsedTime - helperValueTemp.circleTimeAll
        let circleDistance = distance - helperValueTemp.circleDistanceAll
        
        helperValueTemp.savingCircleHelper(circle: 1, circleDistance: circleDistance, circleTime: timeCircles)
                
        return CircleViewModel(circle: "\(Tx.CircleTableResult.circle) \(helperValueTemp.circleCount)",
                               distance: "\(String(format: "%.2f", circleDistance / 1000))",
                               time: "\(timeCircles.toMinutesAndSeconds())")
    }
    
    func getTimerData() -> TimerViewModel {
        let distance = trainingManager.getDistance()
        let avgerageTemp = trainingManager.getAverageTempModel(distance: distance, time: timer.elapsedTime)
        let tempOneKillomert = trainingManager.getTempModel(distance: distance,
                                                            time: timer.elapsedTime,
                                                            kmTraveled: helperValueTemp.kmTraveled,
                                                            kmIteration: helperValueTemp.kmIteration,
                                                            timeAllKM: helperValueTemp.timeAllKM)
                                
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
        trainingManager.coordinates.append(location.coordinate)
        presenter.userLocationIsUpdated()
    }
}

extension StopwatchInteractor: UpdateDataTempDelegate {
    
    func currentDistanceChanged(distance: String) {
        helperValueTemp.savingCurrentDistance(distance: distance)
    }
    
    func сurrentAverageTempChanged(average: String) {
        helperValueTemp.savingCurrentAverageTemp(average: average)
    }
    
    func сurrentTempChanged(temp: String) {
        helperValueTemp.savingCurrentTemp(temp: temp)
    }

    func tempHelper(time: Double, traveled: Double, iteration: Int) {
        helperValueTemp.savingTempHelper(time: time, traveled: traveled, iteration: iteration)
    }
}
