//
//  Interval.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import Foundation

// MARK: - TimeInterval
/// Represents a `TimeInterval` to be started/ended/stored/vizalized/etc
struct TimeInterval {
    /// The stable identifier of this `TimeInterval`
    var id: UUID
    /// The start time of this `TimeInterval`
    var startTime: Date
    /// The optional end time of this `TimeInterval` with nil representing an active one
    var endTime: Date?
    /// The  `Activity` this `TimeInterval` is linked to
    var activityType: ActivityType.ID?

    /// A computed property indicating whether this `TimeInterval` is still active
    var isActive: Bool {
        endTime == nil
    }

    /// - Parameters:
    ///     - id: The stable identity of the `TimeInterval` (generated from init by default)
    ///     - startTime: The startTime of the `TimeInterval` (generated from init by default as the current date)
    ///     - endTime: The endTime of the `TimeInterval` (by default nil indicating that this `ActivityType` is stil active)
    init(id: UUID = UUID(), startTime: Date = Date(), endTime: Date? = nil, activityType: ActivityType.ID?) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.activityType = activityType
    }

    /// Stop this `TimeInterval` at the given (by default current) time
    mutating func stop(date time: Date = Date()) {
        // Assure this interval was not stopped already
        guard endTime == nil else {
            return
        }

        endTime = time
    }
}

// MARK: TimeInterval: Identifiable
extension TimeInterval: Identifiable { }

// MARK: TimeInterval: Comparable
extension TimeInterval: Comparable {
    static func < (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.startTime > rhs.startTime
    }
}
