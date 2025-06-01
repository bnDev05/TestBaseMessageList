//
//  DateFormatterManager.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import Foundation

final class DateFormatterManager {
    
    // MARK: - Shared Instance
    
    static let shared = DateFormatterManager()
    
    // MARK: - Private Formatters
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    private let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Formats time for message display (HH:mm)
    func formatTime(from date: Date) -> String {
        return timeFormatter.string(from: date)
    }
    
    /// Formats date for section headers (MMM d)
    func formatDay(from date: Date) -> String {
        return dayFormatter.string(from: date)
    }
    
    /// Formats full date and time for detailed display
    func formatFullDateTime(from date: Date) -> String {
        return fullDateFormatter.string(from: date)
    }
    
    /// Returns relative time string (Today, Yesterday, etc.)
    func formatRelativeTime(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDate(date, equalTo: now, toGranularity: .weekOfYear) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        } else {
            return formatDay(from: date)
        }
    }
}
