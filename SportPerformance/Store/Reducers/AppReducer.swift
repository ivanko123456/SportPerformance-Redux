//
//  AppReducer.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import Foundation

func appReducer(
    fetch: FetchSportPerformancesUseCase,
    save: SaveSportPerformanceUseCase,
    delete: DeleteSportPerformanceUseCase
) -> Reducer<AppState> {
        let listR = listReducer(fetch: fetch, delete: delete)
        let addR = addReducer(save: save)
        
        return { state, action in
            var effects: [Effect] = []
            effects += listR(&state.list, action)
            effects += addR(&state.add, action)
            return effects
        }
    }
