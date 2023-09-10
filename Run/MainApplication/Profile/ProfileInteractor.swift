//
//  ProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation
import Combine

// MARK: Protocol - ProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol ProfilePresenterToInteractorProtocol: AnyObject {
    var user: AppUser { get }
    var balance: Balance? { get }
    var dataSource: ProfileViewModel { get }
    
    func fetchUserBalance()
    func subscribeOnUserChanged()
    func signOut()
}

final class ProfileInteractor {
    
    // MARK: Properties
    weak var presenter: ProfileInteractorToPresenterProtocol!
    
    private let _dataSource: [ProfileTableViewCellViewModel.CellType]
    private var _user: AppUser
    private var _balance: Balance?
    private var store: AnyCancellable?

    init() {
        _user = GlobalData.userModel.value ?? .init(id: "", name: "")
        _dataSource = [.editProfile, .exit]
    }
}

// MARK: Extension - ProfilePresenterToInteractorProtocol
extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    var user: AppUser {
        return _user
    }
    
    var balance: Balance? {
        return _balance
    }
    
    var dataSource: ProfileViewModel {
        return .init(cells: _dataSource.map {.init(type: $0)})
    }
    
    @MainActor
    func fetchUserBalance() {
        Task {
            do {
                let balance = try await DatabaseService.shared.getBalance(for: _user.getId())
                _balance = balance
                presenter.userBalanceIsFetched()
            } catch {
                
            }
        }
    }
    
    func subscribeOnUserChanged() {
        store = GlobalData.userModel.sink { [weak self] user in
            guard let user else { return }
            self?._user = user
            self?.presenter.userIsChanged()
        }
    }
    
    func signOut() {
        GlobalData.userModel.send(nil)
    }
}
