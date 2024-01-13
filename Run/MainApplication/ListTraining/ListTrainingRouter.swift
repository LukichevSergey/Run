//
//  ListTrainingRouter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation
import OrderedCollections

// MARK: Protocol - ListTrainingPresenterToRouterProtocol (Presenter -> Router)
protocol ListTrainingPresenterToRouterProtocol: AnyObject {
    func navigationToDetailedViewController(itemTraining: TrainingCellViewModel)
    func navigateToChartsViewController()
}

final class ListTrainingRouter {
    
    // MARK: Properties
    weak var view: ListTrainingRouterToViewProtocol!
}

// MARK: Extension - ListTrainingPresenterToRouterProtocol
extension ListTrainingRouter: ListTrainingPresenterToRouterProtocol {
    func navigateToChartsViewController() {
        let chartsViewController = ChartsConfigurator().configure()
        view.pushView(view: chartsViewController)
    }
    
    func navigationToDetailedViewController(itemTraining: TrainingCellViewModel) {
        let detailedTrainingViewController = DetailedTrainingConfigurator().configure(with: itemTraining)
        view.pushView(view: detailedTrainingViewController)
    }
}
