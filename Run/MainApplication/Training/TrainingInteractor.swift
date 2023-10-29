//
//  TrainingInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import Foundation
import OrderedCollections

// MARK: Protocol - TrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol TrainingPresenterToInteractorProtocol: AnyObject {
    func fetchTrainings()
}

class TrainingInteractor {

    // MARK: Properties
    weak var presenter: TrainingInteractorToPresenterProtocol!
    private let dataBase: TrainingToDatabaseServiceProtocol
    private var _trainings = OrderedSet<Training>()
    var managerProgress = ProgressTrainingManager()
    
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - TrainingPresenterToInteractorProtocol
extension TrainingInteractor: TrainingPresenterToInteractorProtocol {
    
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                _trainings = trainings
                
                let stepAndMetrProgressTraining = managerProgress.getStepsAndMetrCountForTraining(data: trainings)
                presenter.trainingProgressStepAndKm(data: stepAndMetrProgressTraining)

                presenter.trainingsIsFetched(data: _trainings)
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
