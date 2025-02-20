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
    var color: Color = .black
}

extension Counter {
    var counterString: String {
        get { String(count) }
        set { count = Int(newValue) ?? count }
    }
}

enum CounterAction {
    case increment
    case decrement
    case reset
    case setCount(String)
}

struct CounterEnvironment {}

// 2
let counterReducer = Reducer<Counter, CounterAction, CounterEnvironment> {
    state, action, _ in
    switch action {
    case .increment:
        // 3
        state.count += 1
    case .decrement:
        // 3
        state.count -= 1
    case .reset:
        state.count = 0
    case .setCount(let text):
        state.counterString = text
    }
    state.color = getColor(count: state.count)
    return .none
}.debug()

private func getColor(count: Int) -> Color {
    switch count {
    case 1...: .red
    case ..<0: .green
    default: .black
    }
}

struct ContentView: View {
    let store: Store<Counter, CounterAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Button("reset") { viewStore.send(.reset) }
                HStack {
                    // 1
                    Button("-") { viewStore.send(.decrement) }
                    TextField(
                        String(viewStore.count),
                        text: viewStore.binding(
                            get: \.counterString,
                            send: CounterAction.setCount
                        )
                    )
                    .frame(width: 40)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(
                        viewStore.color
                    )
                    Button("+") { viewStore.send(.increment) }
                }
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
