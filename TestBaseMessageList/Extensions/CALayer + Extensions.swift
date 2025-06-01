//
//  CALayer + Extensions.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit

// MARK: - CALayer Helpers
extension CALayer {
    func applyShadow() {
        shadowColor = UIColor.shadow.cgColor
        shadowOffset = .zero
        shadowRadius = 30
        shadowOpacity = 1.0
    }
}
