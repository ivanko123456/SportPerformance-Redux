//
//  SportPerformanceRepositoryImpl.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation

final class SportPerformanceRepositoryImpl: SportPerformanceRepositoryProtocol {
    
    private let remote: RemoteDataSourceProtocol
    private let local: LocalDataSourceProtocol

    init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }

    func fetchAll() async throws -> [SportPerformance] {
        let remotes = try await remote.fetchAll()
        var locals = try await local.fetchAll()
        
        let newPerformances = remotes.filter { remote in
            !locals.contains { $0.id == remote.id }
        }

        for performance in newPerformances {
            try await local.save(performance)
            locals.append(performance)
        }
        
        let sortedLocals = locals.sorted { $0.date > $1.date }

        return sortedLocals
    }

    func save(_ performance: SportPerformance) async throws {
        if performance.isLocal {
            try await local.save(performance)
        } else {
            try await remote.save(performance)
            try await local.save(performance)
        }
    }
    
    func delete(_ performance: SportPerformance) async throws {
        if performance.isLocal {
            try await local.delete(performance)
        } else {
            try await remote.delete(performance)
            try await local.delete(performance)
        }
    }
}
