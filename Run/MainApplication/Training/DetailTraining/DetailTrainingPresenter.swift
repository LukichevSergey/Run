//
//  DetailTrainingPresenter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation
import UIKit
import OrderedCollections

// MARK: Protocol - DetailTrainingViewToPresenterProtocol (View -> Presenter)
protocol DetailTrainingViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: Protocol - DetailTrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol DetailTrainingInteractorToPresenterProtocol: AnyObject {
    func trainingsDetailIsFetched(data: OrderedSet<HeaderDetailTrainingViewModel>)
    func trainingIsFetchedWithError(error: Error)}

final class DetailTrainingPresenter {
    
    // MARK: Properties
    var router: DetailTrainingPresenterToRouterProtocol!
    var interactor: DetailTrainingPresenterToInteractorProtocol!
    weak var view: DetailTrainingPresenterToViewProtocol!
    
}

// MARK: Extension - DetailTrainingViewToPresenterProtocol
extension DetailTrainingPresenter: DetailTrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTrainings()
    }
}

// MARK: Extension - DetailTrainingInteractorToPresenterProtocol
extension DetailTrainingPresenter: DetailTrainingInteractorToPresenterProtocol {
    func trainingsDetailIsFetched(data: OrderedCollections.OrderedSet<HeaderDetailTrainingViewModel>) {
        let trainingCellViewModels = data.map { training in
            
            return HeaderDetailTrainingViewModel(month: training.month,
                                                 countTraining: training.countTraining,
                                                 allTime: training.allTime,
                                                 averageTime: training.averageTime,
                                                 training: training.training)
        }
        view.setDetailTrainingData(data: trainingCellViewModels)
        view.removeActivityIndicator()
    }
    
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
