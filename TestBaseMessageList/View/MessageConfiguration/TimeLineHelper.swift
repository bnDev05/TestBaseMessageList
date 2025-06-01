//
//  TimeLineHelper.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 01/06/25.
//

import UIKit
import CoreText

enum TextLineHelper {
    static func getTextLines(
        text: String,
        maxWidth: CGFloat,
        font: UIFont
    ) -> [String] {
        let attributedString = NSAttributedString(
            string: text,
            attributes: [.font: font]
        )

        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        let path = CGPath(
            rect: CGRect(x: 0, y: 0, width: maxWidth, height: .greatestFiniteMagnitude),
            transform: nil
        )
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)

        let lines = CTFrameGetLines(frame)
        let lineCount = CFArrayGetCount(lines)

        var textLines: [String] = []
        for i in 0..<lineCount {
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            let range = CTLineGetStringRange(line)
            let lineString = (text as NSString).substring(with: NSRange(location: range.location, length: range.length))
            textLines.append(lineString.trimmingCharacters(in: .whitespacesAndNewlines))
        }

        return textLines
    }
}
