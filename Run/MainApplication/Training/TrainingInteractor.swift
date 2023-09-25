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
    private var _trainings = OrderedSet<Training>()
}

// MARK: Extension - TrainingPresenterToInteractorProtocol
extension TrainingInteractor: TrainingPresenterToInteractorProtocol {
    
    @MainActor
    func fetchTrainings() {
        Task {
            do {
                let trainings = try await DatabaseService.shared.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                _trainings = trainings
                presenter.trainingsIsFetched()
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
