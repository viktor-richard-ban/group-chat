//
//  Middleware.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 09..
//

protocol Middleware {
    /// Connects the middleware to a store.
    ///
    /// Called when the middleware is registered with a store. Use this to:
    /// - Keep a reference to the store for dispatching actions
    /// - Subscribe to state changes
    /// - Initialize any required resources
    ///
    /// - Parameter store: The store instance to attach to.
    func attach(store: any Store)
    
    /// Handle an incoming action and optionally dispatch new actions
    /// - Parameter action: The action that was dispatched
    func handle(action: Action)
}
