//
//  Store+App.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import CoreData

extension Store {
    static func makeAppStore(
      initialState: AppState = .init(),
      fetch: FetchSportPerformancesUseCase,
      save: SaveSportPerformanceUseCase,
      delete: DeleteSportPerformanceUseCase) -> Store {
      let reducer = appReducer(fetch: fetch, save: save, delete: delete)
      return Store(initialState: initialState, reducer: reducer)
    }
}
