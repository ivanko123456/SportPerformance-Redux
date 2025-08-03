//
//  Store.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import SwiftUI

@MainActor
final class Store: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: Reducer<AppState>
    private var cancellables = Set<AnyCancellable>()
    
    init(
        initialState: AppState,
        reducer: @escaping Reducer<AppState>
    ) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        let effects = reducer(&state, action)
        
        effects.forEach { effect in
            effect
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &cancellables)
        }
    }
}
