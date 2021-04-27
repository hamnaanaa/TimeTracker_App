//
//  Model.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import Foundation

// MARK: - Model
/// The `Model` for the Time Tracker App
class Model: ObservableObject {
    /// All `Activity` entries stored as a list
    @Published var activityTypes: [ActivityType]
    /// All `TimeInterval`s stored as a list
    @Published var timeIntervals: [TimeInterval]
    
    /// Store the active `TimeInterval` internally to access its id in a constant time to modify the interval if needed
    private var activeTimeIntervals: [TimeInterval] = []
    
    /// - Parameters:
    ///     - storedActivities: All `ActivityType`s stored as a list
    ///     - allActivityNames: All available `ActivityType` names
    init(activityTypes: [ActivityType] = [], timeIntervals: [TimeInterval] = []) {
        self.activityTypes = activityTypes
        self.timeIntervals = timeIntervals
        
        updateStates()
    }
    
    /// Updates the states of this `Model`
    func updateStates() {
        self.activeTimeIntervals = self.timeIntervals.filter { $0.isActive }
    }
}


// MARK: - Model + ActivityType
extension Model {
    /// Get an `ActivityType` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `ActivityType`  to find
    /// - Returns: The corresponding `ActivityType` if there exists one with the specified id, otherwise nil
    func activityType(_ id: ActivityType.ID?) -> ActivityType? {
        activityTypes.first { $0.id == id }
    }
    
    
    /// Change the `ActivityType`'s state by toggling its isActive property and manage the corresponding `TimeInterval`s
    /// - Parameters:
    ///    - id: The id of the `ActivityType` to update
    func toggleActivityType(with id: ActivityType.ID) {
        guard let index = activityTypes.firstIndex(where: { $0.id == id }) else {
            return
        }
        activityTypes[index].toggle()
        
        let currentActivityType = activityTypes[index]
        if currentActivityType.isActive {
            let newTimeInterval = TimeInterval(activityType: currentActivityType.id)
            
            timeIntervals.append(newTimeInterval)
            activeTimeIntervals.append(newTimeInterval)
        } else {
            guard let activeTimeInterval = activeTimeIntervals.first(where: { $0.activityType == currentActivityType.id }),
                  let index = timeIntervals.firstIndex(where: { $0.id == activeTimeInterval.id }) else {
                // there is no active interval associated with the currentActivity that was stopped
                return
            }
            
            self.activeTimeIntervals = activeTimeIntervals.filter { $0.id != activeTimeInterval.id }
            timeIntervals[index].stop()
        }
    }
}


// MARK: - Model + TimeInterval
extension Model {
    /// Get a `TimeInterval` for a specific ID from all `TimeInterval`s
    /// - Parameters:
    ///    - id: The id of the `TimeInterval`  to find
    /// - Returns: The corresponding `TimeInterval` if there exists one with the specified id, otherwise nil
    func timeInterval(_ id: TimeInterval.ID) -> TimeInterval? {
        timeIntervals.first { $0.id == id }
    }
    
    /// Get a `TimeInterval` for a specific ID *only* from *active* `TimeInterval`s
    /// - Parameters:
    ///    - id: The id of the `TimeInterval`  to find
    /// - Returns: The corresponding `TimeInterval` if there exists one with the specified id, otherwise nil
    func activeTimeInterval(_ id: TimeInterval.ID) -> TimeInterval? {
        activeTimeIntervals.first { $0.id == id }
    }
    
    
    /// Find the latest `TimeInterval` associated with the given `ActivityType` and return its start and end times
    /// - Parameters:
    ///    - id: The id of the `ActivityType` to use in the search for the `TimeInterval`
    /// - Returns: A tuple of two optional dates (start & end times)
    /// startTime might be nil, if there is no `TimeInterval` associated with the given `ActivityType`. In this case the endTime is also nil
    /// In addition, endTime might be nil, if the found `TimeInterval` is still active
    func latestIntervalTimes(of activityTypeID: ActivityType.ID) -> (Date?, Date?) {
        let latestTimeInterval = timeIntervals
            .filter { $0.activityType == activityTypeID }
            .sorted()
            .first
        
        return (latestTimeInterval?.startTime, latestTimeInterval?.endTime)
    }
    
    
    /// Calculate the total `TimeInterval`s duration sum associated with the given `ActivityType`
    /// - Parameters:
    ///    - id: The id of the `ActivityType` to use in the search for the `TimeInterval`s
    /// - Returns: Total number of seconds
    func cumulativeIntervalTimes(of activityTypeID: ActivityType.ID) -> Double {
        // FEATURE: consider only time intervals from today
        timeIntervals
            .filter { $0.activityType == activityTypeID }
            .reduce(0) { accum, timeInterval in
            if timeInterval.isActive {
                return accum + Date().timeIntervalSince(timeInterval.startTime)
            } else {
                return accum + timeInterval.endTime!.timeIntervalSince(timeInterval.startTime)
            }
        }
    }
    
    
    /// Delete the specified `TimeInterval`
    /// - Parameters:
    ///     - id: The identifier of the `TimeInterval` to delete
    func delete(timeInterval id: TimeInterval.ID) {
        // !!! FIXME: something is wrong with sorting the timeintervals after deletion
        if let activityID = activityType(activeTimeInterval(id)?.activityType)?.id {
            activeTimeIntervals.removeAll(where: { $0.id == id })
            toggleActivityType(with: activityID)
        }
        timeIntervals.removeAll(where: { $0.id == id })
    }
}
