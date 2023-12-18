//
//  TrainingInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import OrderedCollections

// MARK: Protocol - TrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol TrainingPresenterToInteractorProtocol: AnyObject {
    func fetchTrainings()
    var training: OrderedSet<TrainingCellViewModel> { get }
}

final class TrainingInteractor {

    // MARK: Properties
    weak var presenter: TrainingInteractorToPresenterProtocol!
    private let dataBase: TrainingToDatabaseServiceProtocol
    private var _trainings = OrderedSet<Training>()
    var managerProgress = ProgressTrainingManager()
    private let trainingInformationManager = InformationTrainingManager()
    
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - TrainingPresenterToInteractorProtocol
extension TrainingInteractor: TrainingPresenterToInteractorProtocol {
    var training: OrderedCollections.OrderedSet<TrainingCellViewModel> {
        let listSortedTraining = trainingInformationManager.getTrainingForDetailed(data: _trainings)

        return listSortedTraining
    }
    
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                _trainings = trainings
                let stepAndMetrProgressTraining = managerProgress.getStepsAndKmCountForTraining(data: trainings)
                let informationTraining = trainingInformationManager.getinformationAllTraining(data: trainings)
                presenter.trainingsIsFetched(data: informationTraining)
                presenter.trainingProgressStepAndKm(data: stepAndMetrProgressTraining)
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
