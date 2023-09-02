//
//  DatabaseService.swift
//  Run
//
//  Created by Лукичев Сергей on 02.09.2023.
//

import Foundation
import FirebaseFirestore

final class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() { }
    
    func setUser(user: AppUser, completion: @escaping (Result<AppUser, Error>) -> Void) {
        userRef.document(user.id).setData(user.toDict) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(completion: @escaping (Result<AppUser, Error>) -> Void) {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        userRef.document(currentUser.uid).getDocument { doc, error in
            guard let snapshot = doc else { return }
            guard let data = snapshot.data() else { return }
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            
            let user = AppUser(id: id, name: userName)
        
            completion(.success(user))
        }
    }
}
