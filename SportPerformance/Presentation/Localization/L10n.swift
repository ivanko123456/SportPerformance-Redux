//
//  L10n.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 27/07/2025.
//

import SwiftUI

enum L10n {
    enum AddSportPerformance {
        static let navigationTitle = LocalizedStringKey("add_sport_performance_nav_title")
        static let namePlaceholder = LocalizedStringKey("add_sport_performance_name_placeholder")
        static let placePlaceholder = LocalizedStringKey("add_sport_performance_place_placeholder")
        static let lengthPlaceholder = LocalizedStringKey("add_sport_performance_length_placeholder")
        static let saveButton = LocalizedStringKey("add_sport_performance_save_button")
        static let doneButton = LocalizedStringKey("add_sport_performance_done_button")
        static let okButton = LocalizedStringKey("add_sport_performance_ok_button")
        static let saveLocal = LocalizedStringKey("add_sport_performance_save_local")
        static let saveRemote = LocalizedStringKey("add_sport_performance_save_remote")
    }
    
    enum SportPerformanceList {
        static let navigationTitle    = LocalizedStringKey("sport_performance_list_nav_title")
        static let filterAll = LocalizedStringKey("sport_performance_list_filter_all")
        static let filterLocal = LocalizedStringKey("sport_performance_list_filter_local")
        static let filterRemote = LocalizedStringKey("sport_performance_list_filter_remote")
        static let noSavedPerformance = LocalizedStringKey("sport_performance_list_no_saved_performance")
    }
}
