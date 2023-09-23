//
//  EditProfileRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//  
//

import Foundation

// MARK: Protocol - EditProfilePresenterToRouterProtocol (Presenter -> Router)
protocol EditProfilePresenterToRouterProtocol: AnyObject {
    func navigateToPreviouslyLevel()
}

final class EditProfileRouter {

    // MARK: Properties
    weak var view: EditProfileRouterToViewProtocol!
}

// MARK: Extension - EditProfilePresenterToRouterProtocol
extension EditProfileRouter: EditProfilePresenterToRouterProtocol {
    func navigateToPreviouslyLevel() {
        logger.log("\(#fileID) -> \(#function)")
        view.popView()
    }
}
