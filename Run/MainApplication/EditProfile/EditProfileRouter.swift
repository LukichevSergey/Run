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

}

final class EditProfileRouter {

    // MARK: Properties
    weak var view: EditProfileRouterToViewProtocol!
}

// MARK: Extension - EditProfilePresenterToRouterProtocol
extension EditProfileRouter: EditProfilePresenterToRouterProtocol {
    
}
