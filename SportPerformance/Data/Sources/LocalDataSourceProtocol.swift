//
//  LocalDataSourceProtocol.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

protocol LocalDataSourceProtocol {
    func fetchAll() async throws -> [SportPerformance]
    func save(_ performance: SportPerformance) async throws
    func delete(_ performance: SportPerformance) async throws
}
