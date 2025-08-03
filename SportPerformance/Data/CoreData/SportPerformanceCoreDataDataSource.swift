//
//  SportPerformanceCoreDataDataSource.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation
import CoreData

final class SportPerformanceCoreDataDataSource: LocalDataSourceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchAll() async throws -> [SportPerformance] {
        try await context.perform {
            let request: NSFetchRequest<SportPerformanceEntity> = SportPerformanceEntity.fetchRequest()
            let entities = try self.context.fetch(request)
            return entities.compactMap { $0.toDomainModel() }
        }
    }

    func save(_ performance: SportPerformance) async throws {
        try await context.perform {
            let entity = SportPerformanceEntity(context: self.context)
            entity.date = performance.date
            entity.id = performance.id ?? UUID().uuidString
            entity.isLocal = performance.isLocal
            entity.length = performance.length
            entity.name = performance.name
            entity.place = performance.place
            try self.context.save()
        }
    }

    func delete(_ performance: SportPerformance) async throws {
        try await context.perform {
            guard let id = performance.id else { return }
            let request: NSFetchRequest<SportPerformanceEntity> = SportPerformanceEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            if let entity = try self.context.fetch(request).first {
                self.context.delete(entity)
                try self.context.save()
            }
        }
    }
}
