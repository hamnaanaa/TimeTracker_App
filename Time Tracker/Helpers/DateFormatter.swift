//
//  DateFormatter.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 20.04.21.
//

import Foundation

// MARK: - DateFormatter
/// An extension for `DateFormatter` to simplify working with dates in the project
extension DateFormatter {
    /// Formatter that includes the date as well as the time.
    /// Example: September 3, 2018 at 3:38 PM
    public static let dateAndTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    /// Formatter that includes only the date.
    /// Example: 9/3/18
    public static let onlyDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    /// Formatter that includes only the date.
    /// Example: 3:38 PM
    public static let onlyTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter
    }()
}
