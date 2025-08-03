//
//  FetchSportPerformancesUseCase.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation

struct FetchSportPerformancesUseCase {
    private let repository: SportPerformanceRepositoryProtocol

    init(repository: SportPerformanceRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [SportPerformance] {
        try await repository.fetchAll()
    }
}
