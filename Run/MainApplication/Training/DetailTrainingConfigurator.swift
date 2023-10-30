//
//  DetailTrainingConfigurator.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation
import UIKit

class DetailTrainingConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = DetailTrainingViewController()
        let presenter = DetailTrainingPresenter()
        let router = DetailTrainingRouter()
        let interactor = DetailTrainingInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
