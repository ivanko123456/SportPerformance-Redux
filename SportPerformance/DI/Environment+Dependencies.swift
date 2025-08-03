//
//  Environment+Dependencies.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import SwiftUI

private struct DependenciesKey: EnvironmentKey {
    static let defaultValue: AppDependencies = .live
}

extension EnvironmentValues {
    var dependencies: AppDependencies {
        get { self[DependenciesKey.self] }
        set { self[DependenciesKey.self] = newValue }
    }
}
