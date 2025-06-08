//
//  ListenMessagesUseCaseImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

final class ListenMessagesUseCaseImpl: ListenMessagesUseCase {
    private let store: ChatStore
    private var stream: AsyncStream<MessageApiModel>
    private var task: Task<Void, Never>?
    
    init(service: ChatService,
         store: ChatStore) {
        self.stream = service.listen()
        self.store = store
    }
    
    func listen() {
        task?.cancel()
        task = Task {
            for await messageApiModel in stream {
                let message = map(messageApiModel)
                store.reduce(.show(message))
            }
        }
    }
    
    private func map(_ apiModel: MessageApiModel) -> Message {
        switch apiModel {
        case .text(let textMessageApiModel):
            return Message(text: textMessageApiModel.text, type: .received)
        }
    }
}
