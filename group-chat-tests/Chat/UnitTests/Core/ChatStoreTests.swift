//
//  ChatStoreTests.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 12..
//

@testable import Group_Chat
import Combine
import Testing

@Suite(.tags(.unit_test))
struct ChatStoreTests {}


// MARK: Test cases
extension ChatStoreTests {
    @Test("Middleware receives actions in store dispatch")
    func middlewareReceivesActions() {
        // Given
        let middleware = MiddlewareMock()
        let store = ChatStore(middlewares: [middleware])
        let message = Message(text: "Hi", type: .sent)
        
        // When
        store.dispatch(.send(message))
        
        // Then
        #expect(middleware.handleCallCount == 1)
        #expect(middleware.handledActions.last as? ChatAction == .send(message))
        #expect(middleware.attachCallCount == 1)
        #expect(middleware.attachedStores.last as? ChatStore === store)
    }
}
