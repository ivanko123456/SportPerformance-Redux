//
//  SportPerformance.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation

struct SportPerformance: Identifiable, Equatable {
    public let id: String?
    public let date: Date
    public let isLocal: Bool
    public let length: Double
    public let name: String
    public let place: String

    public init(
        id: String? = nil,
        date: Date,
        isLocal: Bool,
        length: Double,
        name: String,
        place: String
    ) {
        self.id = id
        self.date = date
        self.isLocal = isLocal
        self.length = length
        self.name = name
        self.place = place
    }
}
