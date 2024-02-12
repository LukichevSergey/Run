//
//  ListTrainingInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import OrderedCollections

// MARK: Protocol - ListTrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol ListTrainingPresenterToInteractorProtocol: AnyObject {
    func fetchTrainings()
    func deleteCellTraining(iD: String)
    var trainingAll: OrderedSet<SectionListTrainingModel> { get }
    var listTraining: OrderedSet<SectionListTrainingModel> { get }
}

final class ListTrainingInteractor {
    // MARK: Properties
    weak var presenter: ListTrainingInteractorToPresenterProtocol!
    private let managerListTraining =  ListTrainingManager()
    private let dataBase: TrainingToDatabaseServiceProtocol
    private var _listTraining = OrderedSet<SectionListTrainingModel>()
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - ListTrainingPresenterToInteractorProtocol
extension ListTrainingInteractor: ListTrainingPresenterToInteractorProtocol {
    var trainingAll: OrderedCollections.OrderedSet<SectionListTrainingModel> {
        let trainingAll = _listTraining

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
    var listTraining: OrderedCollections.OrderedSet<SectionListTrainingModel> {
        return _listTraining
    }
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                async let listSortedTraining = managerListTraining.getListTrainingAndHeaderMonth(data: trainings)
                _listTraining = await listSortedTraining
                await presenter.trainingsListIsFetched(data: listSortedTraining)
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
