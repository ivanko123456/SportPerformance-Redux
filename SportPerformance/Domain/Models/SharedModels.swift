//
//  SharedModels.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Foundation
import SwiftUI

enum SaveMode: CaseIterable {
    case local
    case backend
    
    var title: LocalizedStringKey {
        switch self {
        case .local: return L10n.AddSportPerformance.saveLocal
        case .backend: return L10n.AddSportPerformance.saveRemote
        }
    }
}

enum Filter: CaseIterable, Identifiable {
    case all
    case local
    case backend
    
    var id: Filter { self }
    
    var title: LocalizedStringKey {
        switch self {
        case .all: return L10n.SportPerformanceList.filterAll
        case .local: return L10n.SportPerformanceList.filterLocal
        case .backend: return L10n.SportPerformanceList.filterRemote
        }
    }
}