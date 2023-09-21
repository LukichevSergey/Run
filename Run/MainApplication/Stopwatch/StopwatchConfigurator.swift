//
//  StopwatchConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit

final class StopwatchConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = StopwatchViewController()
        let presenter = StopwatchPresenter()
        let router = StopwatchRouter()
        let interactor = StopwatchInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
