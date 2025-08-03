//
//  AppDependencies.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import CoreData

enum AppDependencies {
    case live
    case test

    private var repository: SportPerformanceRepositoryProtocol {
        switch self {
        case .live:
            let container = NSPersistentContainer(name: "SportPerformance")
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Core Data load error: \(error)")
                }
            }
            return SportPerformanceRepositoryImpl(
                remote: SportPerformanceAPIDataSource(),
                local: SportPerformanceCoreDataDataSource(context: container.viewContext)
            )
        case .test:
            return MockSportPerformanceRepository()
        }
    }

    var fetchUseCase: FetchSportPerformancesUseCase {
        FetchSportPerformancesUseCase(repository: repository)
    }

    var saveUseCase: SaveSportPerformanceUseCase {
        SaveSportPerformanceUseCase(repository: repository)
    }

    var deleteUseCase: DeleteSportPerformanceUseCase {
        DeleteSportPerformanceUseCase(repository: repository)
    }

    @MainActor
    var store: Store {
         Store.makeAppStore(
            initialState: .init(),
            fetch: fetchUseCase,
            save: saveUseCase,
            delete: deleteUseCase
        )
    }
}
