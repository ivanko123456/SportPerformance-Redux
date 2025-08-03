//
//  AddReducer.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import Foundation

func addReducer(save: SaveSportPerformanceUseCase) -> Reducer<AddPerformanceState> {
    { state, action in
        switch action {
        case .setName(let s):
            state.name = s
            return []
            
        case .setPlace(let s):
            state.place = s
            return []
            
        case .setLength(let s):
            state.length = s
            return []
            
        case .setMode(let m):
            state.saveMode = m
            return []
            
        case .savePerformance:
            state.isSaving = true
            state.error = nil
            let performance = SportPerformance(
                id: nil,
                date: Date(),
                isLocal: state.saveMode == .local,
                length: Double(state.length) ?? 0,
                name: state.name,
                place: state.place
            )
            let effect = Deferred {
                Future<Action, Never> { promise in
                    Task {
                        do {
                            try await save.execute(performance)
                            promise(.success(.saveSuccess))
                        } catch {
                            let err = AddPerformanceError.network(description: error.localizedDescription)
                            promise(.success(.saveFailure(err)))
                        }
                    }
                }
            }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            return [effect]
            
        case .saveSuccess:
            state.isSaving = false
            state.didSave = true
            return []
            
        case .saveFailure(let err):
            state.error = err
            state.isSaving = false
            return []
            
        case .resetAddPerformance:
            state = AddPerformanceState()
            return []
            
        default:
            return []
        }
    }
}
