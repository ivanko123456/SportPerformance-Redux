//
//  AppState.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Foundation

struct AppState {
    var list = PerformanceListState()
    var add  = AddPerformanceState()
}

struct PerformanceListState {
    var performances: [SportPerformance] = []
    var isLoading = false
    var error: String?
    var filter: Filter = .all
    
    var filtered: [SportPerformance] {
        switch filter {
        case .all:     return performances
        case .local:   return performances.filter(\.isLocal)
        case .backend: return performances.filter { !$0.isLocal }
        }
    }
}

struct AddPerformanceState {
    var name: String = ""
    var place: String = ""
    var length: String = ""
    var saveMode: SaveMode = .local
    var isSaving: Bool = false
    var didSave: Bool = false
    var error: AddPerformanceError?
}
