//
//  EditProfileConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//  
//

import UIKit

final class EditProfileConfigurator {
    func configure(with profile: AppUser) -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = EditProfileViewController()
        let presenter = EditProfilePresenter()
        let router = EditProfileRouter()
        let interactor = EditProfileInteractor(with: profile)
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
