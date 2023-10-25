//
//  TrainingPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import Foundation
import OrderedCollections
import UIKit

// MARK: Protocol - TrainingViewToPresenterProtocol (View -> Presenter)
protocol TrainingViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
}

// MARK: Protocol - TrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol TrainingInteractorToPresenterProtocol: AnyObject {
    func trainingsIsFetched(data: OrderedSet<Training>)
    func trainingProgressKm(data: Float)
    func trainingProgressStep(data: Float)
    func trainingIsFetchedWithError(error: Error)
}

class TrainingPresenter {

    // MARK: Properties
    var router: TrainingPresenterToRouterProtocol!
    var interactor: TrainingPresenterToInteractorProtocol!
    weak var view: TrainingPresenterToViewProtocol!
    
    weak var progressBar: ProgressBarViewProtocol?
}

// MARK: Extension - TrainingViewToPresenterProtocol
extension TrainingPresenter: TrainingViewToPresenterProtocol {
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
        var trainingCellViewModels = data.map { training in
            
            return TrainingCellViewModel(killometrs: "\(String(format: "%.2f", training.distance)) км",
                                         image: UIImage(named: "circle") ?? UIImage(),
                                         data: "\(training.startTime.formatData()) >",
                                         title: Tx.Training.run)
        }
        trainingCellViewModels.sort { $0.data > $1.data }
        view.setTrainingData(data: trainingCellViewModels)
        view.removeActivityIndicator()
    }
    
    func trainingProgressKm(data: Float) {
        logger.log("\(#fileID) -> \(#function)")
        view.setTrainingProgressKm(km: data, kmLabel: "\(String(format: "%.0f", data)) / ??")
    }
    
    func trainingProgressStep(data: Float) {
        logger.log("\(#fileID) -> \(#function)")
        view.setTrainingProgressStep(step: data, stepLabel: "\(String(format: "%.0f", data)) / ??")
    }
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
