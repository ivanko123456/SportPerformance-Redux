//
//  AddPerformanceError.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Foundation

enum AddPerformanceError: Error, Identifiable, LocalizedError {
    case network(description: String)
    case validation(message: String)
    case unknown(Error)
    
    var id: String {
        switch self {
        case .network: return "network_error"
        case .validation: return "validation_error"
        case .unknown: return "unknown_error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .network(let desc):    return "Network error: \(desc)"
        case .validation(let msg):  return msg
        case .unknown(let err):     return err.localizedDescription
        }
    }
}
