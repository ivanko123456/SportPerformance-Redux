//
//  ListReducer.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import Foundation

func listReducer(
    fetch: FetchSportPerformancesUseCase,
    delete: DeleteSportPerformanceUseCase
) -> Reducer<PerformanceListState> {
        { state, action in
            switch action {
            case .loadPerformances:
                state.isLoading = true
                state.error = nil
                let effect = Deferred {
                    Future<Action, Never> { promise in
                        Task {
                            do {
                                var items = try await fetch.execute()
                                items.sort { $0.date > $1.date }
                                promise(.success(.loadSuccess(items)))
                            } catch {
                                promise(.success(.loadFailure(error.localizedDescription)))
                            }
                        }
                    }
                }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
                return [effect]
                
            case .loadSuccess(let items):
                state.performances = items
                state.isLoading = false
                return []
                
            case .loadFailure(let msg):
                state.error = msg
                state.isLoading = false
                return []
                
            case .deletePerformance(let item):
                state.isLoading = true
                state.error = nil
                let effect = Deferred {
                    Future<[Action], Never> { promise in
                        Task {
                            do {
                                try await delete.execute(item)
                                promise(.success([.deleteSuccess, .loadPerformances]))
                            } catch {
                                promise(.success([.deleteFailure(error.localizedDescription)]))
                            }
                        }
                    }
                }
                    .flatMap { Publishers.Sequence(sequence: $0) }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
                return [effect]
                
            case .deleteSuccess:
                state.isLoading = false
                return []
                
            case .deleteFailure(let msg):
                state.error = msg
                state.isLoading = false
                return []
                
            case .setFilter(let filter):
                state.filter = filter
                return []
                
            default:
                return []
            }
        }
    }
