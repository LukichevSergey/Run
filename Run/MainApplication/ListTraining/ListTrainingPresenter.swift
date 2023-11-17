//
//  ListTrainingPresenter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import UIKit
import OrderedCollections

// MARK: Protocol - ListTrainingViewToPresenterProtocol (View -> Presenter)
protocol ListTrainingViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: Protocol - ListTrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ListTrainingInteractorToPresenterProtocol: AnyObject {
    func trainingsListIsFetched(data: OrderedSet<SectionListTrainingModel>)
    func trainingIsFetchedWithError(error: Error)}

final class ListTrainingPresenter {
    
    // MARK: Properties
    var router: ListTrainingPresenterToRouterProtocol!
    var interactor: ListTrainingPresenterToInteractorProtocol!
    weak var view: ListTrainingPresenterToViewProtocol!
}

// MARK: Extension - ListTrainingViewToPresenterProtocol
extension ListTrainingPresenter: ListTrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTrainings()
    }
}

// MARK: Extension - ListTrainingInteractorToPresenterProtocol
extension ListTrainingPresenter: ListTrainingInteractorToPresenterProtocol {
    func trainingsListIsFetched(data: OrderedCollections.OrderedSet<SectionListTrainingModel>) {
        logger.log("\(#fileID) -> \(#function)")
        let listTrainingsInArray = data.map { training in
            
            return SectionListTrainingModel(month: training.month,
                                                 countTraining: training.countTraining,
                                                 allTime: training.allTime,
                                                 averageTime: training.averageTime,
                                                 training: training.training)
        }
        view.setListTrainingData(data: listTrainingsInArray)
        view.removeActivityIndicator()
    }
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
