//
//  TrainingRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

// MARK: Protocol - TrainingPresenterToRouterProtocol (Presenter -> Router)
protocol TrainingPresenterToRouterProtocol: AnyObject {
    func navigateToListViewController()
    func navigationToDetailedViewController(itemTraining: TrainingCellViewModel)
}

final class TrainingRouter {

    // MARK: Properties
    weak var view: TrainingRouterToViewProtocol!
}

// MARK: Extension - TrainingPresenterToRouterProtocol
extension TrainingRouter: TrainingPresenterToRouterProtocol {
    func navigateToListViewController() {
        let listTrainingViewController = ListTrainingConfigurator().configure()
        view.pushView(view: listTrainingViewController)
    }
    func navigationToDetailedViewController(itemTraining: TrainingCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        let detailedTrainingViewController = DetailedTrainingConfigurator().configure(with: itemTraining)
        view.pushView(view: detailedTrainingViewController)
    }
}
