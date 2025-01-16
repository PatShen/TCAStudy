//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by swx on 2025/1/4.
//

import XCTest
@testable import ComposableArchitecture
@testable import TCADemo

final class TCADemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCounterIncrement() throws {
        let store = TestStore(
            initialState: Counter(count: Int.random(in: 0...100)),
            reducer: counterReducer,
            environment: CounterEnvironment()
        )
        store.send(.increment) { state in
            state.count += 1
            state.color = .red
        }
    }

    func testCounterDecrement() throws {
        let store = TestStore(
            initialState: Counter(count: Int.random(in: -100...0)),
            reducer: counterReducer,
            environment: CounterEnvironment()
        )
        store.send(.decrement) { state in
            state.count -= 1
            state.color = .green
        }
    }

    func testCounterReset() throws {
        let store = TestStore(
            initialState: Counter(count: Int.random(in: -100...100)),
            reducer: counterReducer,
            environment: CounterEnvironment()
        )
        store.send(.reset) { state in
            state.count = 0
            state.color = .black
        }
    }
}
