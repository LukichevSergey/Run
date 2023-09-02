//
//  AuthManager.swift
//  Run
//
//  Created by Лукичев Сергей on 31.08.2023.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()

    init() { }

    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let _ = result {
                DatabaseService.shared.getUser { result in
                    switch result {
                    case .success(let appUser):
                        completion(.success(appUser))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            } else if let error {
                completion(.failure(error))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result {
                let user = AppUser(id: result.user.uid, name: "")
                DatabaseService.shared.setUser(user: user) { resultDB in
                    switch resultDB {
                    case .success:
                        completion(.success(user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error {
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {

    }
}
