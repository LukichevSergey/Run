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
    func saveTraining()
}

final class StopwatchInteractor {
    
    private let timerManager: TimerManager
    private let locationManager: LocationManager
    private let trainingManager: TrainingManager
    
    private var coordinates: [CLLocationCoordinate2D] = []
        
    private var helperTemp = HelperValueTempsModel()

    // MARK: Properties
    weak var presenter: StopwatchInteractorToPresenterProtocol!
    
    init() {
        timerManager = TimerManager()
        trainingManager = TrainingManager(user: GlobalData.userModel.value ?? AppUser(id: "", name: ""))
        locationManager = LocationManager()
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
        helperTemp.resetAll()
    }
    
    func roundResult() -> CircleViewModel {
        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        helperTemp.circle += 1
        let timeCircles = timer.elapsedTime - helperTemp.circleTimeAll
        helperTemp.circleTimeAll += timeCircles
        let circleDistance = distance - helperTemp.circleDistanceAll
        helperTemp.circleDistanceAll += circleDistance
        
        return CircleViewModel(circle: "\(Tx.CircleTableResult.circle) \(helperTemp.circle)", distance: "\(String(format: "%.2f", circleDistance / 1000))", time: "\(timeCircles.toMinutesAndSeconds())")
    }
    
    func getTimerData() -> TimerViewModel {
        var coordinates = trainingManager.getCurrentTrainingCoordinates()
        coordinates.append(self.coordinates)
        let distance = coordinates.reduce(0) { partialResult, coordinates in
            partialResult + locationManager.calculateDistance(routeCoordinates: coordinates)
        }
        let avgerageTemp = trainingManager.getAverageTempModel(dist: distance, time: timer.elapsedTime)
        let tempOneKillomert = trainingManager.getTempModel(distance: distance, time: timer.elapsedTime)
                
        return TimerViewModel(kilometrModel: .init(data: "\(String(format: "%.2f", distance / 1000))", description: Tx.Timer.kilometr),
                              tempModel: .init(data: "\(tempOneKillomert)", description: Tx.Timer.temp),
                              averageTempModel: .init(data: "\(avgerageTemp)", description: Tx.Timer.averageTemp))
    }
    
    func requestAuthorization() {
        locationManager.requestAuthorization()
    }
    
    func saveTraining() {
        Task {
            do {
                guard let training = trainingManager.getLastTraining() else { return }
                try await DatabaseService.shared.saveTraining(training: training)
            } catch {
                
            }
        }
    }
}

extension StopwatchInteractor: LocationManagerDelegate {
    func didUpdateUserLocation(_ location: CLLocation) {
        guard trainingManager.trainingStatus == .start else { return }
        coordinates.append(location.coordinate)
        presenter.userLocationIsUpdated()
    }
}
