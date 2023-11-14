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
    func setActiveSnakers(for userId: String, selectedId: String) async throws
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
    func updateSneakers(for userId: String, on distance: Double) async throws
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
    
    func setActiveSnakers(for userId: String, selectedId: String) async throws {
        logger.log("\(#fileID) -> \(#function)")
        
        let querySnapshot = try await sneakersRef.whereField("userId", isEqualTo: userId).getDocuments()
        
        let batch = db.batch()
        
        for document in querySnapshot.documents {
            let shoeRef = sneakersRef.document(document.documentID)
            
            // Проверяем, является ли текущая кроссовка выбранной
            let isCurrentShoe = document.documentID == selectedId
            
            // Устанавливаем нужный статус для текущей кроссовки
            let updatedData = ["isActive": isCurrentShoe]
            batch.updateData(updatedData, forDocument: shoeRef)
        }
        
        try await batch.commit()
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
    
    func updateSneakers(for userId: String, on distance: Double) async throws {
        logger.log("\(#fileID) -> \(#function)")
        
        let querySnapshot = try await sneakersRef.whereField("userId", isEqualTo: userId).whereField("isActive", isEqualTo: true).getDocuments()
        
        let batch = db.batch()
        
        for document in querySnapshot.documents {
            let shoeRef = sneakersRef.document(document.documentID)
            let currentDistance = document.data()["distance"] as? Double ?? 0
            let currentTrainings = document.data()["trainingsCount"] as? Int ?? 0
            let currentCondition = document.data()["condition"] as? Double ?? 0
            let currentMoney = document.data()["money"] as? Double ?? 0
            
            let updatedData = ["distance": ((currentDistance + distance) * 100).rounded() / 100,
                               "trainingsCount": currentTrainings + 1,
                               "condition": ((currentCondition - distance) * 100).rounded() / 100,
                               "money": ((currentMoney + distance * 10) * 100).rounded() / 100] as [String : Any]

            batch.updateData(updatedData, forDocument: shoeRef)
        }
        
        try await batch.commit()
    }
}

extension DatabaseService: EditProfileToDatabaseServiceProtocol {  }
