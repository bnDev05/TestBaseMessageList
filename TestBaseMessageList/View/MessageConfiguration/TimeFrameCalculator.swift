//
//  TimeFrameCalculator.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

enum TimeFrameCalculator {
    static func calculate(
        bubbleSize: CGSize,
        messageFrame: CGRect,
        timeSize: CGSize,
        isTimeSingleLine: Bool,
        isSending: Bool,
        messageText: String,
        messageFont: UIFont
    ) -> CGRect {
        guard !isSending else { return .zero }

        if isTimeSingleLine {
            let availableTextWidth = bubbleSize.width - (Constants.internalPadding * 2)
            let lines = TextLineHelper.getTextLines(text: messageText, maxWidth: availableTextWidth, font: messageFont)

            if lines.last != nil {
                let lineHeight = messageFont.lineHeight
                let lastLineY = Constants.internalVerticalPadding + CGFloat(lines.count - 1) * lineHeight
                return CGRect(
                    x: bubbleSize.width - timeSize.width - Constants.internalPadding,
                    y: lastLineY + lineHeight - timeSize.height + 2,
                    width: timeSize.width,
                    height: timeSize.height
                )
            } else {
                return CGRect(
                    x: messageFrame.maxX + Constants.paddingBetweenMessageAndTime,
                    y: bubbleSize.height - timeSize.height - Constants.internalVerticalPadding,
                    width: timeSize.width,
                    height: timeSize.height
                )
            }
        } else {
            return CGRect(
                x: bubbleSize.width - timeSize.width - Constants.internalPadding,
                y: bubbleSize.height - timeSize.height - Constants.internalVerticalPadding + 1,
                width: timeSize.width,
                height: timeSize.height
            )
        }
    }
}
