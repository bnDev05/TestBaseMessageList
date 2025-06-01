//
//  MessageAppearance.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import UIKit

struct MessageAppearance {
    let bubbleColor: UIColor
    let textColor: UIColor
    let cornerRadius: CGFloat
    let maskedCorners: CACornerMask
}

final class MessageAppearanceManager {
    
    // MARK: - Appearance Calculation
    
    static func appearance(for message: Message) -> MessageAppearance {
        return MessageAppearance(
            bubbleColor: bubbleColor(for: message),
            textColor: textColor(for: message),
            cornerRadius: Constants.cornerRadius,
            maskedCorners: maskedCorners(for: message)
        )
    }
    
    static var timeTextColor: UIColor {
        return Colors.timeText
    }
    
    // MARK: - Private Helpers
    
    private static func bubbleColor(for message: Message) -> UIColor {
        return message.isOutgoing ? Colors.outgoingBubble : Colors.incomingBubble
    }
    
    private static func textColor(for message: Message) -> UIColor {
        return message.isOutgoing ? Colors.outgoingText : Colors.incomingText
    }
    
    private static func maskedCorners(for message: Message) -> CACornerMask {
        return message.isOutgoing ?
            [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner] :
            [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}
