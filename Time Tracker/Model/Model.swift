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
    @Published var activities: [Activity]
    /// All `TimeInterval`s stored as a list
    @Published var timeIntervals: [TimeInterval]
    
    /// Store the active `TimeInterval` internally to access its id in a constant time to modify the interval if needed
    private var activeTimeIntervals: [TimeInterval] = []
    
    /// - Parameters:
    ///     - storedActivities: All `Activity` entries stored as a list
    ///     - allActivityNames: All available `Activity` names
    init(activities: [Activity] = [], timeIntervals: [TimeInterval] = []) {
        self.activities = activities
        self.timeIntervals = timeIntervals
        
        updateStates()
    }
    
    /// Updates the states of this `Model`
    func updateStates() {
        self.activeTimeIntervals = self.timeIntervals.filter { $0.isActive }
    }
    
    /// Get an `Activity` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `Activity`  to find
    /// - Returns: The corresponding `Activity` if there exists one with the specified id, otherwise nil
    func activity(_ id: Activity.ID) -> Activity? {
        activities.first { $0.id == id }
    }
    
    /// Change the `Activity`'s state by toggling its isActive property and manage the corresponding `TimeInterval`s
    /// - Parameters:
    ///    - id: The id of the `Activity` to update
    func toggleActivity(with id: Activity.ID) {
        guard let index = activities.firstIndex(where: { $0.id == id }) else {
            return
        }
        activities[index].toggle()
        
        let currentActivity = activities[index]
        if currentActivity.isActive {
            let newTimeInterval = TimeInterval(activity: currentActivity.id)
            
            timeIntervals.append(newTimeInterval)
            activeTimeIntervals.append(newTimeInterval)
        } else {
            guard let activeTimeInterval = activeTimeIntervals.first(where: { $0.activity == currentActivity.id }),
                  let index = timeIntervals.firstIndex(where: { $0.id == activeTimeInterval.id }) else {
                // there is no active interval associated with the currentActivity that was stopped
                return
            }
            
            self.activeTimeIntervals = activeTimeIntervals.filter { $0.id != activeTimeInterval.id }
            timeIntervals[index].stop()
        }
    }
}
