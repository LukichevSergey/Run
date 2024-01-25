//
//  DetailedTrainingPresenter.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

import UIKit
import OrderedCollections

// MARK: Protocol - DetailedTrainingViewToPresenterProtocol (View -> Presenter)
protocol DetailedTrainingViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: Protocol - DetailedTrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol DetailedTrainingInteractorToPresenterProtocol: AnyObject {
    func trainingIsFetchedWithError(error: Error)
    func detailedTrainingData(data: [EnumDetailedViewCell])
    func dateDetailedHeaderTraining(_ data: String)
}

final class DetailedTrainingPresenter {
    // MARK: Properties
    var router: DetailedTrainingPresenterToRouterProtocol!
    var interactor: DetailedTrainingPresenterToInteractorProtocol!
    weak var view: DetailedTrainingPresenterToViewProtocol!
}

// MARK: Extension - DetailedTrainingViewToPresenterProtocol
extension DetailedTrainingPresenter: DetailedTrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchDetailedTraining()
    }
}

// MARK: Extension - DetailedTrainingInteractorToPresenterProtocol
extension DetailedTrainingPresenter: DetailedTrainingInteractorToPresenterProtocol {
    func detailedTrainingData(data: [EnumDetailedViewCell]) {
        logger.log("\(#fileID) -> \(#function)")
        view.setDetailedTrainingData(data: data)
        view.removeActivityIndicator()
    }
    func dateDetailedHeaderTraining(_ data: String) {
        logger.log("\(#fileID) -> \(#function)")
        view.setDateDetailedHeaderTraining(data)
        view.removeActivityIndicator()
    }
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
