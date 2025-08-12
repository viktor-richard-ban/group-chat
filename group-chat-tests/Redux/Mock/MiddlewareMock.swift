//
//  MiddlewareMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 12..
//

@testable import Group_Chat
import Foundation

final class MiddlewareMock: Middleware {
    var onAttach: ((any Store) -> Void)?
    private(set) var attachCallCount = 0
    private(set) var attachedStores: [any Store] = []
    func attach(store: any Store) {
        attachCallCount += 1
        attachedStores.append(store)
        onAttach?(store)
    }
    
    var onHandle: ((any Action) -> Void)?
    private(set) var handleCallCount = 0
    private(set) var handledActions: [any Action] = []
    func handle(action: any Action) {
        handleCallCount += 1
        handledActions.append(action)
        onHandle?(action)
    }
}
