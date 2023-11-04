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
    func trainingsDetailIsFetched(data: OrderedSet<Training>)
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
    func trainingsDetailIsFetched(data: OrderedCollections.OrderedSet<Training>) {
        let trainingCellViewModels = data.map { training in
            
            return TrainingCellViewModel(killometrs: "\(String(format: "%.2f", training.distance)) км",
                                         image: UIImage(named: "circle") ?? UIImage(),
                                         data: "\(training.startTime.formatData()) >",
                                         title: Tx.Training.run)
        }
        let sortedTrainingCellViewModels = trainingCellViewModels.sorted { $0.data > $1.data }
        view.setDetailTrainingData(data: sortedTrainingCellViewModels)
        view.removeActivityIndicator()
    }
    
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
