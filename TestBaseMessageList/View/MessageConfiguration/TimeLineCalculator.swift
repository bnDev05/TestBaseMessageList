//
//  TimeLineCalculator.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

enum TimeLineCalculator {
    static func canPlaceTimeOnSameLine(
        messageText: String,
        timeWidth: CGFloat,
        maxTextWidth: CGFloat,
        messageFont: UIFont,
        isSending: Bool
    ) -> Bool {
        guard !isSending else { return false }

        let singleLineTextWidth = messageText.size(
            constrainedTo: .greatestFiniteMagnitude,
            font: messageFont
        ).width

        if singleLineTextWidth + Constants.internalPadding + timeWidth <= maxTextWidth {
            return true
        }

        return hasSpaceOnLastLine(
            messageText: messageText,
            timeWidth: timeWidth,
            maxTextWidth: maxTextWidth,
            messageFont: messageFont
        )
    }

    private static func hasSpaceOnLastLine(
        messageText: String,
        timeWidth: CGFloat,
        maxTextWidth: CGFloat,
        messageFont: UIFont
    ) -> Bool {
        let lines = TextLineHelper.getTextLines(
            text: messageText,
            maxWidth: maxTextWidth,
            font: messageFont
        )

        guard let lastLine = lines.last else { return false }

        let lastLineWidth = lastLine.size(
            constrainedTo: .greatestFiniteMagnitude,
            font: messageFont
        ).width

        return lastLineWidth + Constants.internalPadding + timeWidth <= maxTextWidth
    }
}
