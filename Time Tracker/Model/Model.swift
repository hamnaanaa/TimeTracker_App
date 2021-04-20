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
    
    /// Get an `ActivityType` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `ActivityType`  to find
    /// - Returns: The corresponding `ActivityType` if there exists one with the specified id, otherwise nil
    func activityType(_ id: ActivityType.ID?) -> ActivityType? {
        activityTypes.first { $0.id == id }
    }
    
    /// Get a `TimeInterval` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `TimeInterval`  to find
    /// - Returns: The corresponding `TimeInterval` if there exists one with the specified id, otherwise nil
    func timeInterval(_ id: TimeInterval.ID) -> TimeInterval? {
        timeIntervals.first { $0.id == id }
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
