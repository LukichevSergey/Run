//
//  ProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - ProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol ProfilePresenterToInteractorProtocol: AnyObject {
    var user: AppUser { get }
    
    func signOut()
}

final class ProfileInteractor {

    // MARK: Properties
    weak var presenter: ProfileInteractorToPresenterProtocol!
    
    private let _user: AppUser

    init() {
        _user = GlobalData.userModel ?? .init(id: "", name: "")
    }
}

// MARK: Extension - ProfilePresenterToInteractorProtocol
extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    var user: AppUser {
        return _user
    }
    
    func signOut() {
        GlobalData.userModel = nil
    }
}
