//
//  MockDataProvider.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import Foundation

final class MockDataProvider {
    
    // MARK: - Sample Messages
    
    static func generateSampleMessages() -> [Message] {
        let now = Date()
        
        return [
            Message(
                text: "Incoming message",
                date: now.addingTimeInterval(-600), // 5 minutes ago
                isOutgoing: false,
                isSending: false
            ),
            Message(
                text: "Outgoing message",
                date: now.addingTimeInterval(-300), // 5 minutes ago
                isOutgoing: true,
                isSending: false
            ),
            Message(
                text: ".",
                date: now.addingTimeInterval(-240), // 4 minutes ago
                isOutgoing: false,
                isSending: false
            ),
            Message(
                text: "One line message one line message",
                date: now.addingTimeInterval(-180), // 3 minutes ago
                isOutgoing: true,
                isSending: false
            ),
            Message(
                text: "One line message max width one line................",
                date: now.addingTimeInterval(-120), // 2 minutes ago
                isOutgoing: false,
                isSending: false
            ),
            Message(
                text: "Multi line message multi line multi multi on line message multi line message multi line",
                date: now,
                isOutgoing: true,
                isSending: false
            )
        ]
    }
    
    // MARK: - Conversation Templates
    
    static func generateConversationTemplate(type: ConversationType) -> [Message] {
        switch type {
        case .casual:
            return generateCasualConversation()
        case .business:
            return generateBusinessConversation()
        case .support:
            return generateSupportConversation()
        }
    }
    
    private static func generateCasualConversation() -> [Message] {
        let now = Date()
        return [
            Message(text: "Hey! What's up?", date: now.addingTimeInterval(-600), isOutgoing: false),
            Message(text: "Not much, just relaxing. You?", date: now.addingTimeInterval(-550), isOutgoing: true),
            Message(text: "Same here. Want to grab coffee later?", date: now.addingTimeInterval(-500), isOutgoing: false),
            Message(text: "Sure! What time works for you?", date: now.addingTimeInterval(-450), isOutgoing: true)
        ]
    }
    
    private static func generateBusinessConversation() -> [Message] {
        let now = Date()
        return [
            Message(text: "Good morning! I hope you're doing well.", date: now.addingTimeInterval(-1800), isOutgoing: true),
            Message(text: "Good morning! Yes, thank you. How can I help you today?", date: now.addingTimeInterval(-1750), isOutgoing: false),
            Message(text: "I wanted to follow up on our project timeline.", date: now.addingTimeInterval(-1700), isOutgoing: true),
            Message(text: "Of course! Let me pull up the latest updates.", date: now.addingTimeInterval(-1650), isOutgoing: false)
        ]
    }
    
    private static func generateSupportConversation() -> [Message] {
        let now = Date()
        return [
            Message(text: "Hi, I need help with my account.", date: now.addingTimeInterval(-900), isOutgoing: true),
            Message(text: "Hello! I'd be happy to help you with that. What seems to be the issue?", date: now.addingTimeInterval(-850), isOutgoing: false),
            Message(text: "I can't seem to reset my password.", date: now.addingTimeInterval(-800), isOutgoing: true),
            Message(text: "No problem! Let me guide you through the password reset process.", date: now.addingTimeInterval(-750), isOutgoing: false)
        ]
    }
}

// MARK: - Supporting Types

enum ConversationType {
    case casual
    case business
    case support
}
