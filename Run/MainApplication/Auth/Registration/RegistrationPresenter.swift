//
//  RegistrationPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - RegistrationViewToPresenterProtocol (View -> Presenter)
protocol RegistrationViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func authButtonTapped()
    func emailIsChanged(to email: String)
    func passwordIsChanged(to password: String)
}

// MARK: Protocol - RegistrationInteractorToPresenterProtocol (Interactor -> Presenter)
protocol RegistrationInteractorToPresenterProtocol: AnyObject {
    func userIsSingUp()
}

class RegistrationPresenter {

    // MARK: Properties
    var router: RegistrationPresenterToRouterProtocol!
    var interactor: RegistrationPresenterToInteractorProtocol!
    weak var view: RegistrationPresenterToViewProtocol!
}

// MARK: Extension - RegistrationViewToPresenterProtocol
extension RegistrationPresenter: RegistrationViewToPresenterProtocol {
    func emailIsChanged(to email: String) {
        interactor.setEmail(to: email)
    }
    
    func passwordIsChanged(to password: String) {
        interactor.setPassword(to: password)
    }
    
    func authButtonTapped() {
        interactor.signUp()
    }
    
    func viewDidLoad() {
    
    }
}

// MARK: Extension - RegistrationInteractorToPresenterProtocol
extension RegistrationPresenter: RegistrationInteractorToPresenterProtocol {
    func userIsSingUp() {
        router.navigateToMainPage()
    }
}
