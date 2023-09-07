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
    func navigateToEditProfile(with profile: AppUser)
}

final class ProfileRouter {

    // MARK: Properties
    weak var view: ProfileRouterToViewProtocol!
}

// MARK: Extension - ProfilePresenterToRouterProtocol
extension ProfileRouter: ProfilePresenterToRouterProtocol {
    func navigateToEditProfile(with profile: AppUser) {
        let editProfileViewController = EditProfileConfigurator().configure(with: profile)
        view.pushView(view: editProfileViewController)
    }
}
