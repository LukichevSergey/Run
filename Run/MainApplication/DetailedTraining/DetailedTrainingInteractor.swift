//
//  DetailedTrainingInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

// MARK: Protocol - DetailedTrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol DetailedTrainingPresenterToInteractorProtocol: AnyObject {
    func fetchDetailedTraining()
}

final class DetailedTrainingInteractor {
    
    // MARK: Properties
    weak var presenter: DetailedTrainingInteractorToPresenterProtocol!
    private let _detailedTraining: TrainingCellViewModel
    private let managerDetailed = DetailedTrainingManager()
    
    init(with detailedTraining: TrainingCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        _detailedTraining = detailedTraining
    }
}

// MARK: Extension - DetailedTrainingPresenterToInteractorProtocol
extension DetailedTrainingInteractor: DetailedTrainingPresenterToInteractorProtocol {
    func fetchDetailedTraining(){
        logger.log("\(#fileID) -> \(#function)")
        
        Task {
            let dateHeaderDetailed = managerDetailed.getDateDetailerTrainig(_detailedTraining)
            presenter.DateDetailedHeaderTraining(dateHeaderDetailed)
            
            let detailTrainingArrayFilter = managerDetailed.getDetailedTrainingUnprocessed(_detailedTraining)
            presenter.DetailedTrainingData(data: detailTrainingArrayFilter)
        }
    }
}
