//
//  TimeIntervalCellViewModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 19.04.21.
//

import Foundation
import SwiftUI

// MARK: - TimeIntervalCellViewModel
/// A ViewModel for the `TimeIntervalCell`
class TimeIntervalCellViewModel: ObservableObject {
    /// The start time of this `TimeInterval`
    @Published var startTime: Date = Date()
    /// The optional end time of this `TimeInterval` with nil representing an active one
    @Published var endTime: Date? = nil
    /// Display the duration (for format, see `TimeDisplayer` implementation)
    @Published var timePassed: TimeDisplayer = TimeDisplayer()
    /// The stable identity of the `ActivityType` this `TimeInterval` is linked to
    @Published var activityType: ActivityType.ID? = nil
    /// The `ActivityType` this `TimeInterval` is linked to
    @Published var associatedActivityType: ActivityType? = nil
    
    /// The stable identity of the `TimeInterval`
    var id: TimeInterval.ID
    /// The `Model` to read the `TimeInterval` from
    @ObservedObject var model: Model
    /// A computed property indicating whether this `TimeInterval` is still active
    var isActive: Bool {
        endTime == nil
    }
    
    /// A timer used to refresh the `TimeIntervalCell` every 60 seconds
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    /// - Parameters:
    ///     - model: The `Model` to read the `TimeInterval` from
    ///     - id: The stable identity of the `TimeInterval`
    init(_ model: Model, id: TimeInterval.ID) {
        self.model = model
        self.id = id
        
        updateStates()
    }
    
    /// Update the `TimeIntervalCell`'s state published by this viewModel
    private func updateStates() {
        guard let timeInterval = model.timeInterval(id) else {
            return
        }
        
        self.startTime = timeInterval.startTime
        self.endTime = timeInterval.endTime
        self.activityType = timeInterval.activityType
        self.associatedActivityType = model.activityType(timeInterval.activityType)
        
        updateTimePassed()
    }
    
    /// Re-calculate how much time has passed
    func updateTimePassed() {
        self.timePassed = TimeDisplayer(secondsPassed: isActive ? Date().timeIntervalSince(startTime) : endTime!.timeIntervalSince(startTime))
    }
}
