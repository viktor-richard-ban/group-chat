//
//  Store.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

import Combine

protocol Store {
    /// The type representing the feature's state.
    associatedtype State
    /// The type representing all possible actions that can be dispatched./
    associatedtype Action
    
    /// The collection of middlewares that can intercept actions and perform side effects.
    var middlewares: [any Middleware] { get }
    /// A publisher that emits updates whenever the state changes.
    var state: Published<State>.Publisher { get }
    
    /// Sends an action to the store.
    ///
    /// The store will pass the action through middlewares first, then to the reducer
    /// to update the state.
    ///
    /// - Parameter action: The action to process.
    func dispatch(_ action: Action)
}
