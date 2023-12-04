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
    var listTraining: OrderedCollections.OrderedSet<SectionListTrainingModel> {
        return _listTraining
    }
    
    
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                
                let listSortedTraining = managerListTraining.getListTrainingAndHeaderMonth(data: trainings)
                _listTraining = listSortedTraining
                presenter.trainingsListIsFetched(data: _listTraining)
                
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
