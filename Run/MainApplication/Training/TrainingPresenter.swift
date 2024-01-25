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
    func detailedTappedCell(_ indexPath: IndexPath)
}

// MARK: Protocol - TrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol TrainingInteractorToPresenterProtocol: AnyObject {
    func trainingsIsFetched(data: OrderedSet<TrainingCellViewModel>)
    func trainingProgressStepAndKm(data: [String: Float])
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
    func detailedTappedCell(_ indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        let trainingItem = interactor.training[indexPath.item]
        router.navigationToDetailedViewController(itemTraining: trainingItem)
    }
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTrainings()
    }
}

// MARK: Extension - TrainingInteractorToPresenterProtocol
extension TrainingPresenter: TrainingInteractorToPresenterProtocol {
    func trainingsIsFetched(data: OrderedSet<TrainingCellViewModel>) {
        logger.log("\(#fileID) -> \(#function)")

        view.setTrainingData(data: Array(data))
        view.removeActivityIndicator()
    }

    func trainingProgressStepAndKm(data: [String: Float]) {
        logger.log("\(#fileID) -> \(#function)")
        view.setTrainingProgressStep(step: data["step"] ?? 0, stepLabel: "\(String(format: "%.0f", data["step"] ?? 0))")
        view.setTrainingProgressKm(km: data["km"] ?? 0, kmLabel: "\(String(format: "%.0f", data["km"] ?? 0))")
    }
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
