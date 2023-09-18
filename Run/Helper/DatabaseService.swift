//
//  DatabaseService.swift
//  Run
//
//  Created by Лукичев Сергей on 02.09.2023.
//

import Foundation
import FirebaseFirestore
import OrderedCollections

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
    
    private var trainingRef: CollectionReference {
        return db.collection("training")
    }
    
    private init() { }
    
    func getUser(with id: String) async throws -> AppUser? {
        let snapshot = try await userRef.document(id).getDocument()
        return snapshot.data().flatMap({ AppUser(from: $0) })
    }
    
    func setUser(user: AppUser) async throws {
        try await userRef.document(user.getId()).setData(user.toDict)
    }
    
    func getBalance(for userId: String) async throws -> Balance? {
        let snapshot = try await balanceRef.whereField("userId", isEqualTo: userId).getDocuments()
        let data = snapshot.documents.first?.data()
        return data.flatMap({ Balance(from: $0) })
    }
    
    func setBalance(balance: Balance) async throws {
        try await balanceRef.document(balance.id).setData(balance.toDict)
    }
    
    func setSneakers(sneakers: Sneakers) async throws {
        try await sneakersRef.document(sneakers.id).setData(sneakers.toDict)
    }
    
    func saveTraining(training: Training) async throws {
        try await trainingRef.document(training.id).setData(training.toDict)
    }
    
    func getTrainings(for userId: String) async throws -> OrderedSet<Training> {
        let snapshot = try await trainingRef.whereField("userId", isEqualTo: userId).getDocuments()
        let data = snapshot.documents.reduce(into: [[String: Any]]()) { partialResult, querySnapShot in
            partialResult.append(querySnapShot.data())
        }
        return .init(data.compactMap({ Training(from: $0) }))  
    }
}
