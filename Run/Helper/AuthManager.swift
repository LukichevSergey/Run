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
        logger.log("\(#fileID) -> \(#function)")
        return auth.currentUser
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        logger.log("\(#fileID) -> \(#function)")
        return try await auth.signIn(withEmail: email, password: password)
    }
    
    func signUp(username: String, email: String, password: String) async throws -> AppUser {
        logger.log("\(#fileID) -> \(#function)")
        let result = try await auth.createUser(withEmail: email, password: password)
        
        return AppUser(id: result.user.uid, name: username)
    }
}
