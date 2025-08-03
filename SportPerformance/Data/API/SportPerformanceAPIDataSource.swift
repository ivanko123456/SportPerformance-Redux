//
//  SportPerformanceAPIDataSource.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation
import FirebaseFirestore

final class SportPerformanceAPIDataSource: RemoteDataSourceProtocol {
    
    private lazy var db = Firestore.firestore()
    private let collectionName = "sportPerformances"
    
    func save(_ performance: SportPerformance) async throws {
        let dto = SportPerformanceDTO(from: performance)
        if let id = performance.id {
            let docRef = db.collection(collectionName).document(id)
            try docRef.setData(from: dto)
        } else {
            try db.collection(collectionName).addDocument(from: dto)
        }
    }

    func fetchAll() async throws -> [SportPerformance] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return try snapshot.documents.compactMap { document in
            try document.data(as: SportPerformanceDTO.self).toDomain()
        }
    }
    
    func delete(_ performance: SportPerformance) async throws {
        guard let id = performance.id else { return }
        let docRef = db.collection(collectionName).document(id)
        try await docRef.delete()
    }
}
