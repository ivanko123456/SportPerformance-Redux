//
//  SaveSportPerformanceUseCase.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation

struct SaveSportPerformanceUseCase {
    private let repository: SportPerformanceRepositoryProtocol

    init(repository: SportPerformanceRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ performance: SportPerformance) async throws {
        try await repository.save(performance)
    }
}
