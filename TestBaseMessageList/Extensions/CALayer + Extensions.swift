//
//  CALayer + Extensions.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

// MARK: - CALayer Helpers
extension CALayer {
    func applyShadow(spread: CGFloat = 0) {
        shadowColor = UIColor(red: 130/255, green: 133/255, blue: 147/255, alpha: 0.12).cgColor
        shadowOffset = CGSize(width: 0, height: 2)
        shadowRadius = 15
        shadowOpacity = 1.0
        masksToBounds = false

        if spread != 0 {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        } else {
            shadowPath = nil
        }
    }
}
