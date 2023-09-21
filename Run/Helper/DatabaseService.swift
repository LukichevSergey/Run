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
    
    private var sneakersRef: CollectionReference {
        return db.collection("sneakers")
    }
    
    private var balanceRef: CollectionReference {
        return db.collection("balance")
    }
    
    private init() { }
    
    func getUser(with id: String) async throws -> AppUser? {
        logger.log("\(#fileID) -> \(#function)")
        let snapshot = try await userRef.document(id).getDocument()
        return snapshot.data().flatMap({ AppUser(from: $0) })
    }
    
    func setUser(user: AppUser) async throws {
        logger.log("\(#fileID) -> \(#function)")
        try await userRef.document(user.getId()).setData(user.toDict)
    }
    
    func getBalance(for userId: String) async throws -> Balance? {
        logger.log("\(#fileID) -> \(#function)")
        let snapshot = try await balanceRef.whereField("userId", isEqualTo: userId).getDocuments()
        let data = snapshot.documents.first?.data()
        return data.flatMap({ Balance(from: $0) })
    }
    
    func setBalance(balance: Balance) async throws {
        logger.log("\(#fileID) -> \(#function)")
        try await balanceRef.document(balance.id).setData(balance.toDict)
    }
    
    func setSneakers(sneakers: Sneakers) async throws {
        logger.log("\(#fileID) -> \(#function)")
        try await sneakersRef.document(sneakers.id).setData(sneakers.toDict)
    }
}
