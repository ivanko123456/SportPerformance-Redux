//
//  Action.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Foundation

enum Action {
    // MARK: List
    case loadPerformances
    case loadSuccess([SportPerformance])
    case loadFailure(String)
    case setFilter(Filter)
    case deletePerformance(SportPerformance)
    case deleteSuccess
    case deleteFailure(String)
    
    // MARK: Add
    case setName(String)
    case setPlace(String)
    case setLength(String)
    case setMode(SaveMode)
    case savePerformance
    case saveSuccess
    case saveFailure(AddPerformanceError)
    case resetAddPerformance
}
