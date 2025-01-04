//
//  TCADemoApp.swift
//  TCADemo
//
//  Created by swx on 2025/1/1.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCADemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: Counter(),
                    reducer: counterReducer,
                    environment: CounterEnvironment()
                )
            )
        }
    }
}
