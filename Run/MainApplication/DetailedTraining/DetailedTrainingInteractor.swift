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
    func fetchDetailedTraining() {
        logger.log("\(#fileID) -> \(#function)")
        let dateHeaderDetailed = managerDetailed.getDateDetailerTrainig(_detailedTraining)
        presenter.dateDetailedHeaderTraining(dateHeaderDetailed)
        managerDetailed.getDetailedTrainingUnprocessed(_detailedTraining) { [weak self] detailedTrainingArray in
            self?.presenter.detailedTrainingData(data: detailedTrainingArray)
        }
    }
}
