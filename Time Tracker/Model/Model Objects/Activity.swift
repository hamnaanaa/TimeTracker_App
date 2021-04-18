//
//  Task.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import Foundation
import SwiftUI

// MARK: - Activity
/// Represents an activity that can by activated
struct Activity {
    /// The stable identifier of this `Activity`
    var id: UUID
    /// The name of this `Activity`
    var name: String
    /// The color of this `Activity`
    var color: Color
    /// Indicates whether this `Activity` is active
    var isActive: Bool
    /// The name of the `Image` associated with this `Activity`
    var imageName: String

    
    /// - Parameters:
    ///     - id: The stable identity of the `Activity` (generated from init by default)
    ///     - name: The name of the `Activity`
    ///     - color: The color of the `Activity`
    init(id: UUID = UUID(), name: String, color: Color, isActive: Bool = true, imageName: String = "record.circle") {
        self.id = id
        self.name = name
        self.color = color
        self.isActive = isActive
        self.imageName = imageName
    }
    
    /// Toggle the isActive property
    mutating func toggle() {
        isActive.toggle()
    }
}

// MARK: Activity: Identifiable
extension Activity: Identifiable { }

// MARK: Activity: Comparable
extension Activity: Comparable {
    /// Lexicographic order
    static func < (lhs: Activity, rhs: Activity) -> Bool {
        lhs.name < rhs.name
    }
}
