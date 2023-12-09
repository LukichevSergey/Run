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
}

final class DetailedTrainingPresenter {
    
    // MARK: Properties
    var router: DetailedTrainingPresenterToRouterProtocol!
    var interactor: DetailedTrainingPresenterToInteractorProtocol!
    weak var view: DetailedTrainingPresenterToViewProtocol!
    private let _detailedTraining: TrainingCellViewModel
    private let managerDetailed = DetailedTrainingManager()
    
    init(with detailedTraining: TrainingCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        _detailedTraining = detailedTraining
    }
}

// MARK: Extension - DetailedTrainingViewToPresenterProtocol
extension DetailedTrainingPresenter: DetailedTrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        Task { // именно по этому я думаю что правильнее будет передать в интерактор
            let dateHeaderDetailed = managerDetailed.getDateDetailerTrainig(_detailedTraining)
            DispatchQueue.main.async {
                self.view.setDateDetailedHeaderTraining(dateHeaderDetailed)
            }
            
            let detailTrainingArrayFilter = managerDetailed.getDetailedTrainigUnprocessed(_detailedTraining)
            DispatchQueue.main.async {
                self.view.setDetailedTrainingData(data: detailTrainingArrayFilter)
            }
        }
    }
}

// MARK: Extension - DetailedTrainingInteractorToPresenterProtocol
extension DetailedTrainingPresenter: DetailedTrainingInteractorToPresenterProtocol {
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
