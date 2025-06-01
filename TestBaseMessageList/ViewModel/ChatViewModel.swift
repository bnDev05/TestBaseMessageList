//
//  ChatViewModel.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

// ChatViewModel.swift
import Foundation

protocol ChatViewModelDelegate: AnyObject {
    func chatViewModelDidUpdateMessages(_ viewModel: ChatViewModel)
    func chatViewModel(_ viewModel: ChatViewModel, didUpdateMessage message: Message, at index: Int)
}

final class ChatViewModel {
    
    // MARK: - Properties
    
    weak var delegate: ChatViewModelDelegate?
    
    private let dataSource = MessageDataSource()
    private let dateFormatter = DateFormatterManager.shared
    
    // MARK: - Initialization
    
    init() {
        setupDataSource()
    }
    
    // MARK: - Setup
    
    private func setupDataSource() {
        dataSource.delegate = self
    }
    
    // MARK: - Public Interface
    
    var numberOfMessages: Int {
        return dataSource.numberOfMessages
    }
    
    func message(at index: Int) -> Message? {
        return dataSource.message(at: index)
    }
    
    func formattedTime(for message: Message) -> String {
        return dateFormatter.formatTime(from: message.date)
    }
    
    func formattedRelativeTime(for message: Message) -> String {
        return dateFormatter.formatRelativeTime(from: message.date)
    }
    
    // MARK: - Data Loading
    
    func loadMessages() {
        loadSampleMessages()
    }
    
    func loadSampleMessages() {
        let sampleMessages = MockDataProvider.generateSampleMessages().reversed()
        sampleMessages.forEach { dataSource.addMessage($0) }
    }
    
    func loadConversationTemplate(type: ConversationType) {
        dataSource.clearAllMessages()
        let templateMessages = MockDataProvider.generateConversationTemplate(type: type).reversed()
        templateMessages.forEach { dataSource.addMessage($0) }
    }
    
    // MARK: - Message Operations
    
    func sendMessage(_ text: String) {
        let message = Message(
            text: text,
            isOutgoing: true,
            isSending: true
        )
        dataSource.addMessage(message)
        
        // Simulate sending delay
        simulateMessageSending(message)
    }
    
    func markMessageAsSent(messageId: UUID) {
        guard let index = dataSource.findMessageIndex(by: messageId) else {
            return
        }
        dataSource.markMessageAsSent(at: index)
    }
    
    func deleteMessage(at index: Int) {
        dataSource.removeMessage(at: index)
    }
    
    func clearAllMessages() {
        dataSource.clearAllMessages()
    }
    
    // MARK: - Private Methods
    
    private func simulateMessageSending(_ message: Message) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.markMessageAsSent(messageId: message.id)
        }
    }
}

// MARK: - MessageDataSourceDelegate

extension ChatViewModel: MessageDataSourceDelegate {
    func messageDataSourceDidUpdateMessages(_ dataSource: MessageDataSource) {
        delegate?.chatViewModelDidUpdateMessages(self)
    }
    
    func messageDataSource(_ dataSource: MessageDataSource, didUpdateMessage message: Message, at index: Int) {
        delegate?.chatViewModel(self, didUpdateMessage: message, at: index)
    }
}
