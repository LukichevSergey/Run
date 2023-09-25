//
//  ProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation
import Combine
import OrderedCollections

// MARK: Protocol - ProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol ProfilePresenterToInteractorProtocol: AnyObject {
    var user: AppUser { get }
    var balance: Balance? { get }
    var sneakers: OrderedSet<Sneakers> { get }
    var dataSource: ProfileViewModel { get }
    
    func fetchUserData()
    func subscribeOnUserChanged()
    func signOut()
}

final class ProfileInteractor {
    
    // MARK: Properties
    weak var presenter: ProfileInteractorToPresenterProtocol!
    
    private let _dataSource: [ProfileTableViewCellViewModel.CellType]
    private var _user: AppUser
    private var _balance: Balance?
    private var _sneakers: OrderedSet<Sneakers>?
    private var store: AnyCancellable?

    init() {
        logger.log("\(#fileID) -> \(#function)")
        _user = GlobalData.userModel.value ?? .init(id: "", name: "")
        _dataSource = [.editProfile, .exit]
    }
}

// MARK: Extension - ProfilePresenterToInteractorProtocol
extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    var user: AppUser {
        logger.log("\(#fileID) -> \(#function)")
        return _user
    }
    
    var balance: Balance? {
        logger.log("\(#fileID) -> \(#function)")
        return _balance
    }
    
    var dataSource: ProfileViewModel {
        logger.log("\(#fileID) -> \(#function)")
        return .init(cells: _dataSource.map {.init(type: $0)})
    }
    
    var sneakers: OrderedSet<Sneakers> {
        logger.log("\(#fileID) -> \(#function)")
        return _sneakers ?? []
    }
    
    @MainActor
    func fetchUserData() {
        logger.log("\(#fileID) -> \(#function)")
        
        Task {
            do {
                let balance = try await DatabaseService.shared.getBalance(for: _user.getId())
                _balance = balance
                let sneakers = try await DatabaseService.shared.getSneakers(for: _user.getId())
                _sneakers = sneakers
                presenter.userDataIsFetched()
            } catch {
                
            }
        }
    }
    
    func subscribeOnUserChanged() {
        logger.log("\(#fileID) -> \(#function)")
        store = GlobalData.userModel.sink { [weak self] user in
            guard let user else { return }
            self?._user = user
            self?.presenter.userIsChanged()
        }
    }
    
    func signOut() {
        logger.log("\(#fileID) -> \(#function)")
        GlobalData.userModel.send(nil)
    }
}
