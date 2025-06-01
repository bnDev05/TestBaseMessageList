//
//  Model.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import Foundation

struct Message {
    let id: UUID
    let text: String
    let date: Date
    let isOutgoing: Bool
    let isSending: Bool
    
    init(id: UUID = UUID(),
         text: String,
         date: Date = Date(),
         isOutgoing: Bool,
         isSending: Bool = false) {
        self.id = id
        self.text = text
        self.date = date
        self.isOutgoing = isOutgoing
        self.isSending = isSending
    }
}

// MARK: - Message Extensions

extension Message {
    /// Creates a new message with updated sending status
    func withSendingStatus(_ isSending: Bool) -> Message {
        return Message(
            id: self.id,
            text: self.text,
            date: self.date,
            isOutgoing: self.isOutgoing,
            isSending: isSending
        )
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Message: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
