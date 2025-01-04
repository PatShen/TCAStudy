//
//  ContentView.swift
//  TCADemo
//
//  Created by swx on 2025/1/1.
//

import SwiftUI
import ComposableArchitecture

struct Counter: Equatable {
    var count: Int = 0
}

enum CounterAction {
    case increment
    case decrement
}

struct CounterEnvironment {}

// 2
let counterReducer = Reducer<Counter, CounterAction, CounterEnvironment> {
    state, action, _ in
    switch action {
    case .increment:
        // 3
        state.count += 1
        return .none
    case .decrement:
        // 3
        state.count -= 1
        return .none
    }
}.debug()

struct ContentView: View {
    let store: Store<Counter, CounterAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                // 1
                Button("-") { viewStore.send(.decrement) }
                Text("\(viewStore.count)")
                Button("+") { viewStore.send(.increment) }
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: Counter(),
            reducer: counterReducer,
            environment: CounterEnvironment()
        )
    )
}
