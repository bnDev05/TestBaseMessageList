//
//  MessageDataSource.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import Foundation

protocol MessageDataSourceDelegate: AnyObject {
    func messageDataSourceDidUpdateMessages(_ dataSource: MessageDataSource)
    func messageDataSource(_ dataSource: MessageDataSource, didUpdateMessage message: Message, at index: Int)
}

final class MessageDataSource {
    
    // MARK: - Properties
    
    weak var delegate: MessageDataSourceDelegate?
    
    private(set) var messages: [Message] = [] {
        didSet {
            delegate?.messageDataSourceDidUpdateMessages(self)
        }
    }
    
    // MARK: - Public Methods
    
    var numberOfMessages: Int {
        return messages.count
    }
    
    func message(at index: Int) -> Message? {
        guard index >= 0 && index < messages.count else {
            return nil
        }
        return messages[index]
    }
    
    func addMessage(_ message: Message) {
        messages.append(message)
    }
    
    func updateMessage(at index: Int, with updatedMessage: Message) {
        guard index >= 0 && index < messages.count else {
            return
        }
        messages[index] = updatedMessage
        delegate?.messageDataSource(self, didUpdateMessage: updatedMessage, at: index)
    }
    
    func removeMessage(at index: Int) {
        guard index >= 0 && index < messages.count else {
            return
        }
        messages.remove(at: index)
    }
    
    func clearAllMessages() {
        messages.removeAll()
    }
    
    // MARK: - Message Operations
    
    func markMessageAsSent(at index: Int) {
        guard let message = message(at: index), message.isSending else {
            return
        }
        
        let updatedMessage = message.withSendingStatus(false)
        updateMessage(at: index, with: updatedMessage)
    }
    
    func findMessageIndex(by id: UUID) -> Int? {
        return messages.firstIndex { $0.id == id }
    }
}
