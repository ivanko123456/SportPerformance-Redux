//
//  StoreTypes.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 03/08/2025.
//

import Combine
import Foundation

typealias Effect = AnyPublisher<Action, Never>
typealias Reducer<State> = (inout State, Action) -> [Effect]