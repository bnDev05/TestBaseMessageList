//
//  MessageLayoutCalculator.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import UIKit

final class MessageLayoutCalculator {
    static func calculateLayout(
        for message: Message,
        time: String,
        containerWidth: CGFloat,
        messageFont: UIFont,
        timeFont: UIFont
    ) -> MessageLayout {
        let maxBubbleWidth = (containerWidth - Constants.horizontalPadding * 2) * Constants.bubbleWidthRatio
        let maxTextWidth = maxBubbleWidth - (Constants.internalPadding * 2)

        let textSize = message.text.attributedSize(constrainedTo: maxTextWidth, font: messageFont, lineHeight: 22)
        let timeText = message.isSending ? "" : time
        let timeSize = timeText.size(constrainedTo: Constants.timeMaxWidth, font: timeFont)
        let activityIndicatorWidth: CGFloat = message.isSending ? (Constants.indicatorSize + Constants.indicatorSpacing) : 0
        let totalTimeWidth = timeSize.width + activityIndicatorWidth

        let isTimeSingleLine = TimeLineCalculator.canPlaceTimeOnSameLine(
            messageText: message.text,
            timeWidth: totalTimeWidth,
            maxTextWidth: maxTextWidth,
            messageFont: messageFont,
            isSending: message.isSending
        )

        let bubbleWidth = BubbleFrameCalculator.calculateWidth(
            textWidth: textSize.width,
            timeWidth: totalTimeWidth,
            isTimeSingleLine: isTimeSingleLine,
            isSending: message.isSending,
            maxBubbleWidth: maxBubbleWidth
        )

        let bubbleHeight = BubbleFrameCalculator.calculateHeight(
            textHeight: textSize.height,
            timeHeight: timeSize.height,
            isTimeSingleLine: isTimeSingleLine,
            isSending: message.isSending
        )

        let bubbleX = message.isOutgoing ? (containerWidth - bubbleWidth - Constants.horizontalPadding) : Constants.horizontalPadding
        let bubbleFrame = CGRect(x: bubbleX, y: 0, width: bubbleWidth, height: bubbleHeight)
        let messageFrame = CGRect(x: Constants.internalPadding, y: Constants.internalVerticalPadding, width: textSize.width, height: textSize.height)

        let timeFrame = TimeFrameCalculator.calculate(
            bubbleSize: CGSize(width: bubbleWidth, height: bubbleHeight),
            messageFrame: messageFrame,
            timeSize: timeSize,
            isTimeSingleLine: isTimeSingleLine,
            isSending: message.isSending,
            messageText: message.text,
            messageFont: messageFont
        )

        let indicatorFrame = CGRect(
            x: bubbleWidth - Constants.indicatorSize - Constants.indicatorPadding,
            y: bubbleHeight - Constants.indicatorSize - Constants.indicatorPadding,
            width: Constants.indicatorSize,
            height: Constants.indicatorSize
        )

        return MessageLayout(
            bubbleFrame: bubbleFrame,
            messageFrame: messageFrame,
            timeFrame: timeFrame,
            indicatorFrame: indicatorFrame,
            totalHeight: bubbleHeight,
            isTimeSingleLine: isTimeSingleLine
        )
    }
}
