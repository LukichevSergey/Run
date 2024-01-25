//
//  EditProfilePresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//  
//

import Foundation

// MARK: Protocol - EditProfileViewToPresenterProtocol (View -> Presenter)
protocol EditProfileViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func userNameTextFieldIsChanged(on text: String)
    func saveButtonTapped()
}

// MARK: Protocol - EditProfileInteractorToPresenterProtocol (Interactor -> Presenter)
protocol EditProfileInteractorToPresenterProtocol: AnyObject {
    func userIsSavedWithError(error: Error)
    func userIsSaved()
}

final class EditProfilePresenter {

    // MARK: Properties
    var router: EditProfilePresenterToRouterProtocol!
    var interactor: EditProfilePresenterToInteractorProtocol!
    weak var view: EditProfilePresenterToViewProtocol!
}

// MARK: Extension - EditProfileViewToPresenterProtocol
extension EditProfilePresenter: EditProfileViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.setTextField(with: interactor.profile.getName())
    }
    func userNameTextFieldIsChanged(on text: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setUserName(on: text)
    }
    func saveButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.saveProfile()
    }
}

// MARK: Extension - EditProfileInteractorToPresenterProtocol
extension EditProfilePresenter: EditProfileInteractorToPresenterProtocol {
    func userIsSaved() {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        router.navigateToPreviouslyLevel()
    }
    func userIsSavedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        view.showErrorAlert(with: error.localizedDescription)
    }
}
