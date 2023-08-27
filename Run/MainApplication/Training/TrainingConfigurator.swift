//
//  TrainingConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import UIKit

class TrainingConfigurator {
    func configure() -> UIViewController {
        let view = TrainingViewController()
        let presenter = TrainingPresenter()
        let router = TrainingRouter()
        let interactor = TrainingInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}