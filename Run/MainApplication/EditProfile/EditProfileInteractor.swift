//
//  EditProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//  
//

import Foundation

// MARK: Protocol - EditProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol EditProfilePresenterToInteractorProtocol: AnyObject {
    var profile: AppUser { get }
    
    func setUserName(on name: String)
    func saveProfile()
}

final class EditProfileInteractor {

    // MARK: Properties
    weak var presenter: EditProfileInteractorToPresenterProtocol!
    
    private let _profile: AppUser

    init(with profile: AppUser) {
        _profile = profile
    }
}

// MARK: Extension - EditProfilePresenterToInteractorProtocol
extension EditProfileInteractor: EditProfilePresenterToInteractorProtocol {
    var profile: AppUser {
        return _profile
    }
    
    func setUserName(on name: String) {
        _profile.setName(on: name)
    }
    
    func saveProfile() {
        DatabaseService.shared.setUser(user: _profile) { [weak presenter] result in
            switch result {
            case .success(let user):
                GlobalData.userModel.send(user)
                presenter?.userIsSaved()
            case .failure(let error):
                presenter?.userIsSavedWithError(error: error)
            }
        }
    }
}
