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
    func deleteCellTraining(iD: String)
    var trainingForList: OrderedSet<TrainingCellViewModel> { get }
    var trainingAll: OrderedSet<TrainingCellViewModel> { get }
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
    var trainingAll: OrderedCollections.OrderedSet<TrainingCellViewModel> {
        let trainingAll = trainingInformationManager.getinformationAllTraining(data: _trainings)

        return trainingAll
    }
    func deleteCellTraining(iD: String) {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                try await dataBase.deleteCellTraining(id: iD)
            } catch {
                throw error
            }
        }
    }
    var trainingForList: OrderedCollections.OrderedSet<TrainingCellViewModel> {
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
                async let stepAndMetrProgressTraining = managerProgress.getStepsAndKmCountForTraining()
                async let informationTraining = trainingInformationManager.getinformationAllTraining(data: trainings)
                await presenter.trainingsIsFetched(data: informationTraining)
                await presenter.trainingProgressStepAndKm(data: stepAndMetrProgressTraining)
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
