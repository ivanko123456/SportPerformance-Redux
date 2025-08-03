//
//  SportPerformanceEntity+Mapping.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation
import CoreData

extension SportPerformanceEntity {
    func toDomainModel() -> SportPerformance? {
        guard
            let id = self.id,
            let date = self.date,
            let name = self.name,
            let place = self.place
        else { return nil }

        return SportPerformance(
            id: id,
            date: date,
            isLocal: self.isLocal,
            length: self.length,
            name: name,
            place: place
        )
    }
}
