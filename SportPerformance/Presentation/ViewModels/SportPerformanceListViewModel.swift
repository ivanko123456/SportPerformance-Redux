//
//  SportPerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class SportPerformanceListViewModel: ObservableObject {
    @Published var items: [SportPerformance] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var filter: Filter = .all
    
    private var cancellables = Set<AnyCancellable>()
    private let store: Store
    
    init(store: Store) {
        self.store = store
        
        store.$state
            .map { $0.list.filtered }
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.list.isLoading }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.list.error }
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.list.filter }
            .assign(to: \.filter, on: self)
            .store(in: &cancellables)
    }
    
    func load() {
        store.dispatch(.loadPerformances)
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map { items[$0] }
            .forEach { store.dispatch(.deletePerformance($0)) }
    }
    
    func setFilter(_ f: Filter) {
        store.dispatch(.setFilter(f))
    }
}
