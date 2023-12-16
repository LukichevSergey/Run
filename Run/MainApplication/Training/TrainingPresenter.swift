//
//  TrainingPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import OrderedCollections
import UIKit

// MARK: Protocol - TrainingViewToPresenterProtocol (View -> Presenter)
protocol TrainingViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func listButtonTapped()
}

// MARK: Protocol - TrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol TrainingInteractorToPresenterProtocol: AnyObject {
    func trainingsIsFetched(data: OrderedSet<Training>)
    func trainingProgressStepAndKm(data: Dictionary<String, Float>)
    func trainingIsFetchedWithError(error: Error)
}

final class TrainingPresenter {

    // MARK: Properties
    var router: TrainingPresenterToRouterProtocol!
    var interactor: TrainingPresenterToInteractorProtocol!
    weak var view: TrainingPresenterToViewProtocol!
    
    weak var progressBar: ProgressBarViewProtocol?
}

// MARK: Extension - TrainingViewToPresenterProtocol
extension TrainingPresenter: TrainingViewToPresenterProtocol {
    func listButtonTapped() {
        router.navigateToListViewController()
    }
    
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTrainings()
    }
}

// MARK: Extension - TrainingInteractorToPresenterProtocol
extension TrainingPresenter: TrainingInteractorToPresenterProtocol {
    func trainingsIsFetched(data: OrderedSet<Training>) {
        logger.log("\(#fileID) -> \(#function)")
        let trainingCellViewModels = data.map { training in
            
            return TrainingCellViewModel(identifier: training.id, killometrs: "\(String(format: "%.2f", training.distance)) км",
                                         image: ListImages.Training.circleIcon ?? UIImage(),
                                         data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                                         title: Tx.Training.run,
                                         dateStartStop: training.startTime.formatDate("MM"),
                                         city: CityCoordinates(latitude: training.coordinatesCity.latitude, longitude: training.coordinatesCity.longitude),
                                         averageTemp: training.averageTemp.toMinutesAndSeconds(),
                                         allTime: training.time.toMinutesAndSeconds(),
                                         everyKilometrs: training.everyTimeKilometrs)
        }
        let sortedTrainingCellViewModels = trainingCellViewModels.sorted { $0.data > $1.data }
        view.setTrainingData(data: sortedTrainingCellViewModels)
        view.removeActivityIndicator()
    }

    func trainingProgressStepAndKm(data: Dictionary<String,Float>) {
        logger.log("\(#fileID) -> \(#function)")
        view.setTrainingProgressStep(step: data["step"] ?? 0, stepLabel: "\(String(format: "%.0f", data["step"] ?? 0)) / ??")
        view.setTrainingProgressKm(km: data["km"] ?? 0, kmLabel: "\(String(format: "%.0f", data["km"] ?? 0)) / ??")
    }
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
