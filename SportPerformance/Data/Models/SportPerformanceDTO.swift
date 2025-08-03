//
//  SportPerformanceDTO.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation
import FirebaseFirestore

struct SportPerformanceDTO: Codable {
    @DocumentID var id: String?
    let date: Date
    let isLocal: Bool
    let length: Double
    let name: String
    let place: String

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case isLocal
        case length
        case name
        case place
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isLocal = try values.decode(Bool.self, forKey: .isLocal)
        let timestamp = try values.decode(Timestamp.self, forKey: .date)
        date = timestamp.dateValue()
        id = try values.decodeIfPresent(String.self, forKey: .id)
        length = try values.decodeIfPresent(Double.self, forKey: .length) ?? 0
        name = try values.decode(String.self, forKey: .name)
        place = try values.decode(String.self, forKey: .place)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isLocal, forKey: .isLocal)
        let timestamp = Timestamp(date: date)
        try container.encode(timestamp, forKey: .date)
        try container.encode(length, forKey: .length)
        try container.encode(name, forKey: .name)
        try container.encode(place, forKey: .place)
    }
}

extension SportPerformanceDTO {
    func toDomain() -> SportPerformance {
        SportPerformance(
            id: id,
            date: date,
            isLocal: isLocal,
            length: length,
            name: name,
            place: place
        )
    }
    
    init(from domain: SportPerformance) {
        self.id = domain.id
        self.date = domain.date
        self.isLocal = domain.isLocal
        self.length = domain.length
        self.name = domain.name
        self.place = domain.place
    }
}
