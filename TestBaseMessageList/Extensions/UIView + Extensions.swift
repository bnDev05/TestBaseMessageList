//
//  UIView + Extensions.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

// MARK: - UIView Helpers
extension UIView {
    func applyRoundedMask(for message: Message) {
        let radiusConfig = message.isOutgoing ?
            (topLeft: 17, topRight: 21, bottomLeft: 17, bottomRight: 2) :
            (topLeft: 21, topRight: 17, bottomLeft: 2, bottomRight: 17)

        let path = UIBezierPath()
        let bounds = self.bounds

        path.move(to: CGPoint(x: bounds.minX + CGFloat(radiusConfig.topLeft), y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - CGFloat(radiusConfig.topRight), y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - CGFloat(radiusConfig.topRight), y: bounds.minY + CGFloat(radiusConfig.topRight)),
                    radius: CGFloat(radiusConfig.topRight),
                    startAngle: .pi * 3 / 2,
                    endAngle: 0,
                    clockwise: true)

        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - CGFloat(radiusConfig.bottomRight)))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - CGFloat(radiusConfig.bottomRight), y: bounds.maxY - CGFloat(radiusConfig.bottomRight)),
                    radius: CGFloat(radiusConfig.bottomRight),
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)

        path.addLine(to: CGPoint(x: bounds.minX + CGFloat(radiusConfig.bottomLeft), y: bounds.maxY))
        path.addArc(withCenter: CGPoint(x: bounds.minX + CGFloat(radiusConfig.bottomLeft), y: bounds.maxY - CGFloat(radiusConfig.bottomLeft)),
                    radius: CGFloat(radiusConfig.bottomLeft),
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)

        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + CGFloat(radiusConfig.topLeft)))
        path.addArc(withCenter: CGPoint(x: bounds.minX + CGFloat(radiusConfig.topLeft), y: bounds.minY + CGFloat(radiusConfig.topLeft)),
                    radius: CGFloat(radiusConfig.topLeft),
                    startAngle: .pi,
                    endAngle: .pi * 3 / 2,
                    clockwise: true)

        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
