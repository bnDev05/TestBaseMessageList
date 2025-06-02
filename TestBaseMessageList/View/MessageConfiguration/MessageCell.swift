//
//  MessageCell.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import UIKit

final class MessageCell: UICollectionViewCell {

    // MARK: - Constants
    static let identifier = "MessageCell"

    private enum Fonts {
        static let message = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let time = UIFont.systemFont(ofSize: 11, weight: .regular)
    }

    // MARK: - UI Components
    private let bubbleContainerView = UIView()
    private let bubbleView = UIView()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.message
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.time
        label.textColor = MessageAppearanceManager.timeTextColor
        return label
    }()
    private let indicatorImage = UIImageView(image: UIImage(resource: .sendingIcon))

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        bubbleContainerView.transform = CGAffineTransform(scaleX: 1, y: -1)
        contentView.addSubview(bubbleContainerView)
        bubbleContainerView.addSubview(bubbleView)
        [messageLabel, timeLabel, indicatorImage].forEach(bubbleView.addSubview(_:))
    }

    // MARK: - Configuration
    func configure(with message: Message, time: String, containerWidth: CGFloat) {
        let layout = MessageLayoutCalculator.calculateLayout(
            for: message,
            time: time,
            containerWidth: containerWidth,
            messageFont: Fonts.message,
            timeFont: Fonts.time
        )

        let appearance = MessageAppearanceManager.appearance(for: message)

        applyLayout(layout)
        applyAppearance(appearance, message: message, time: time)
    }

    // MARK: - Layout Application
    private func applyLayout(_ layout: MessageLayout) {
        bubbleContainerView.frame = layout.bubbleFrame
        bubbleView.frame = bubbleContainerView.bounds
        messageLabel.frame = layout.messageFrame
        timeLabel.frame = layout.timeFrame
        indicatorImage.frame = layout.indicatorFrame
    }

    // MARK: - Appearance Application
    private func applyAppearance(_ appearance: MessageAppearance, message: Message, time: String) {
        bubbleContainerView.clipsToBounds = false
        bubbleContainerView.layer.applyShadow()

        bubbleView.backgroundColor = appearance.bubbleColor
        bubbleView.applyRoundedMask(for: message)

//        messageLabel.text = message.text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22

        let attributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.message,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]

        messageLabel.attributedText = NSAttributedString(string: message.text, attributes: attributes)
        messageLabel.textColor = appearance.textColor
        
        // MARK: - Time Label Attributed Text
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.minimumLineHeight = 14
        timeParagraphStyle.maximumLineHeight = 14

        let timeAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.time,
            .kern: 0,
            .foregroundColor: MessageAppearanceManager.timeTextColor,
            .paragraphStyle: timeParagraphStyle
        ]
        timeLabel.attributedText = NSAttributedString(string: time, attributes: timeAttributes)

        configureSendingState(message: message, time: time)
    }

    private func configureSendingState(message: Message, time: String) {
        let isSending = message.isSending
        indicatorImage.isHidden = !isSending
        timeLabel.isHidden = isSending
        if !isSending {
            let timeParagraphStyle = NSMutableParagraphStyle()
            timeParagraphStyle.minimumLineHeight = 14
            timeParagraphStyle.maximumLineHeight = 14

            let timeAttributes: [NSAttributedString.Key: Any] = [
                .font: Fonts.time,
                .kern: 0,
                .foregroundColor: MessageAppearanceManager.timeTextColor,
                .paragraphStyle: timeParagraphStyle
            ]
            timeLabel.attributedText = NSAttributedString(string: time, attributes: timeAttributes)
        }
    }

    // MARK: - Height Calculation
    static func height(for message: Message, containerWidth: CGFloat, time: String) -> CGFloat {
        MessageLayoutCalculator.calculateLayout(
            for: message,
            time: time,
            containerWidth: containerWidth,
            messageFont: Fonts.message,
            timeFont: Fonts.time
        ).totalHeight
    }
}
