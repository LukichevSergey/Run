//
//  ProfilePresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - ProfileViewToPresenterProtocol (View -> Presenter)
protocol ProfileViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType)
}

// MARK: Protocol - ProfileInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ProfileInteractorToPresenterProtocol: AnyObject {

}

final class ProfilePresenter {

    // MARK: Properties
    var router: ProfilePresenterToRouterProtocol!
    var interactor: ProfilePresenterToInteractorProtocol!
    weak var view: ProfilePresenterToViewProtocol!
}

// MARK: Extension - ProfileViewToPresenterProtocol
extension ProfilePresenter: ProfileViewToPresenterProtocol {
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType) {
        switch type {
        case .editProfile:
            return
        case .exit:
            interactor.signOut()
        }
    }
    
    func viewDidLoad() {
        view.setUsername(on: interactor.user.name)
        view.setData(interactor.dataSource)
    }
}

// MARK: Extension - ProfileInteractorToPresenterProtocol
extension ProfilePresenter: ProfileInteractorToPresenterProtocol {
    
}
