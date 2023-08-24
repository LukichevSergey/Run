//
//  ProfileRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - ProfilePresenterToRouterProtocol (Presenter -> Router)
protocol ProfilePresenterToRouterProtocol: AnyObject {

}

class ProfileRouter {

    // MARK: Properties
    weak var view: ProfileRouterToViewProtocol!
}

// MARK: Extension - ProfilePresenterToRouterProtocol
extension ProfileRouter: ProfilePresenterToRouterProtocol {
    
}