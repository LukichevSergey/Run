//
//  DetailTrainingInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation
import OrderedCollections

// MARK: Protocol - DetailTrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol DetailTrainingPresenterToInteractorProtocol: AnyObject {
    func fetchTrainings()

}

class DetailTrainingInteractor {

    // MARK: Properties
    weak var presenter: DetailTrainingInteractorToPresenterProtocol!
    private let managerDetailTraining =  DetailTrainingManager()
    private let dataBase: TrainingToDatabaseServiceProtocol
    private var _detailTrainings = OrderedSet<HeaderDetailTrainingViewModel>()
    
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - DetailTrainingPresenterToInteractorProtocol
extension DetailTrainingInteractor: DetailTrainingPresenterToInteractorProtocol {
    
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                
                let detailSectionTraining = managerDetailTraining.getDetailTrainingAndHeaderMonth(data: trainings)
                _detailTrainings = detailSectionTraining
                presenter.trainingsDetailIsFetched(data: _detailTrainings)
                
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
    
}
