//
//  String + Extensions.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import UIKit

extension String {
    func size(constrainedTo width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return CGSize(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
    }
}
