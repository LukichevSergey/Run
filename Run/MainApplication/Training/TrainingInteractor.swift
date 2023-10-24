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
    var managerProgress = ProgressTrainingManager()
    private var _trainings = OrderedSet<Training>()

}

// MARK: Extension - TrainingPresenterToInteractorProtocol
extension TrainingInteractor: TrainingPresenterToInteractorProtocol {
    
    @MainActor
    func fetchTrainings() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await DatabaseService.shared.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                _trainings = trainings
                
                let kmProgressTraining = managerProgress.progressKmTraining(data: trainings)
                presenter.trainingProgressKm(data: kmProgressTraining )
                
                let pedometrProgressTraining = managerProgress.getStepsCountForTraining(data: trainings)
                presenter.trainingProgressStep(data: Float(pedometrProgressTraining))
                
                presenter.trainingsIsFetched(data: _trainings)
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
