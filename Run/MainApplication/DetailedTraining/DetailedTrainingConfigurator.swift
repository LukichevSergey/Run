//
//  DetailedTrainingConfigurator.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

import UIKit

final class DetailedTrainingConfigurator {
    func configure(with idTrainingItem: TrainingCellViewModel) -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = DetailedTrainingViewController()
        let presenter = DetailedTrainingPresenter()
        let router = DetailedTrainingRouter()
        let interactor = DetailedTrainingInteractor(with: idTrainingItem)
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        router.view = view
        return view
    }
}
