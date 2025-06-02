//
//  BubbleFrameCalculator.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

enum BubbleFrameCalculator {
    static func calculateWidth(
        textWidth: CGFloat,
        timeWidth: CGFloat,
        isTimeSingleLine: Bool,
        isSending: Bool,
        maxBubbleWidth: CGFloat
    ) -> CGFloat {
        let contentWidth = textWidth + (isTimeSingleLine ? (timeWidth + Constants.paddingBetweenMessageAndTime) : 0)
        let totalWidth = contentWidth + (Constants.internalPadding * 2)
        return max(Constants.minBubbleWidth, min(totalWidth, maxBubbleWidth))
    }

    static func calculateHeight(
        textHeight: CGFloat,
        timeHeight: CGFloat,
        isTimeSingleLine: Bool,
        isSending: Bool
    ) -> CGFloat {
        var height = textHeight + (Constants.internalVerticalPadding * 2) + 1
        if !isSending && !isTimeSingleLine {
            height += timeHeight + Constants.timeSpacing
        }
        return height
    }
}
