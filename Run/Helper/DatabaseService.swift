//
//  DatabaseService.swift
//  Run
//
//  Created by Лукичев Сергей on 02.09.2023.
//

import Foundation
import FirebaseFirestore
import OrderedCollections

protocol ProfileToDatabaseServiceProtocol {
    func getBalance(for userId: String) async throws -> Balance?
    func getSneakers(for userId: String) async throws -> OrderedSet<Sneakers>
}

protocol TrainingToDatabaseServiceProtocol {
    func getTrainings(for userId: String) async throws -> OrderedSet<Training>
}

protocol RegistrationToDatabaseServiceProtocol {
    func setUser(user: AppUser) async throws
    func setBalance(balance: Balance) async throws
    func setSneakers(sneakers: Sneakers) async throws
}

protocol LoginToDatabaseServiceProtocol {
    func getUser(with id: String) async throws -> AppUser?
}

protocol EditProfileToDatabaseServiceProtocol {
    func setUser(user: AppUser) async throws
}

protocol StopwatchToDatabaseServiceProtocol {
    func saveTraining(training: Training) async throws
}

final class DatabaseService {
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
}

private extension DatabaseService {
    func getCollection<T: DictionaryConvertible>(for userId: String, from ref: CollectionReference) async throws -> OrderedSet<T> {
        let snapshot = try await ref.whereField("userId", isEqualTo: userId).getDocuments()
        let data = snapshot.documents.reduce(into: [[String: Any]]()) { partialResult, querySnapShot in
            partialResult.append(querySnapShot.data())
        }
        return .init(data.compactMap({ T(from: $0) }))
    }
}

extension DatabaseService: ProfileToDatabaseServiceProtocol {
    func getBalance(for userId: String) async throws -> Balance? {
        logger.log("\(#fileID) -> \(#function)")
        let snapshot = try await balanceRef.whereField("userId", isEqualTo: userId).getDocuments()
        let data = snapshot.documents.first?.data()
        return data.flatMap({ Balance(from: $0) })
    }
    
    func getSneakers(for userId: String) async throws -> OrderedSet<Sneakers> {
        logger.log("\(#fileID) -> \(#function)")
        return try await getCollection(for: userId, from: sneakersRef)
    }
}

extension DatabaseService: TrainingToDatabaseServiceProtocol {
    func getTrainings(for userId: String) async throws -> OrderedSet<Training> {
        logger.log("\(#fileID) -> \(#function)")
        return try await getCollection(for: userId, from: trainingRef)
    }
}

extension DatabaseService: RegistrationToDatabaseServiceProtocol {
    func setUser(user: AppUser) async throws {
        logger.log("\(#fileID) -> \(#function)")
        try await userRef.document(user.getId()).setData(user.toDict)
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

extension DatabaseService: LoginToDatabaseServiceProtocol {
    func getUser(with id: String) async throws -> AppUser? {
        logger.log("\(#fileID) -> \(#function)")
        let snapshot = try await userRef.document(id).getDocument()
        return snapshot.data().flatMap({ AppUser(from: $0) })
    }
}

extension DatabaseService: StopwatchToDatabaseServiceProtocol {
    func saveTraining(training: Training) async throws {
        logger.log("\(#fileID) -> \(#function)")
        try await trainingRef.document(training.id).setData(training.toDict)
    }
}

extension DatabaseService: EditProfileToDatabaseServiceProtocol {  }
