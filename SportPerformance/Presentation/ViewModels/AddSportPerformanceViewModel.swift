//
//  AddSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import SwiftUI
import Combine

struct IdentifiableError: Identifiable, LocalizedError {
    let id = UUID()
    let message: String
    
    var errorDescription: String? { message }
}

@MainActor
final class AddSportPerformanceViewModel: ObservableObject {
    @Published var length = ""
    @Published var name = ""
    @Published var place = ""
    @Published var saveMode: SaveMode = .local
    @Published var isSaving = false
    @Published var error: IdentifiableError?
    @Published var didSave = false
    
    private let store: Store
    private var cancellables = Set<AnyCancellable>()
    
    init(store: Store) {
        self.store = store
        
        store.$state
            .map { $0.add.name }
            .assign(to: \.name, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.add.place }
            .assign(to: \.place, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.add.length }
            .assign(to: \.length, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.add.saveMode }
            .assign(to: \.saveMode, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.add.isSaving }
            .assign(to: \.isSaving, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { state in
                state.add.error.map { IdentifiableError(message: $0.localizedDescription) }
            }
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
        
        store.$state
            .map { $0.add.didSave }
            .assign(to: \.didSave, on: self)
            .store(in: &cancellables)
    }
    
    var isValid: Bool {
        !name.isEmpty
        && !place.isEmpty
        && !length.isEmpty
        && (Double(length) ?? 0) != .zero
    }
    
    func save() async {
        store.dispatch(.savePerformance)
    }
    
    func reset() {
        store.dispatch(.resetAddPerformance)
    }
    
    func setName(_ name: String) {
        store.dispatch(.setName(name))
    }
    
    func setPlace(_ place: String) {
        store.dispatch(.setPlace(place))
    }
    
    func setLength(_ length: String) {
        store.dispatch(.setLength(length))
    }
    
    func setSaveMode(_ mode: SaveMode) {
        store.dispatch(.setMode(mode))
    }
}
