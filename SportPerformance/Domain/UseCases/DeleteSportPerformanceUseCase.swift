//
//  DeleteSportPerformanceUseCase.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 27/07/2025.
//

import Foundation

struct DeleteSportPerformanceUseCase {
    private let repository: SportPerformanceRepositoryProtocol

    init(repository: SportPerformanceRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ performance: SportPerformance) async throws {
        try await repository.delete(performance)
    }
}
