//
//  TaskCellViewModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import Foundation
import SwiftUI

// MARK: - ActivityCellViewModel
/// A ViewModel for the `ActivityTypeCell`
class ActivityTypeCellViewModel: ObservableObject {
    // State properties
    /// The name of this `ActivityType`
    @Published var name: String = ""
    /// Indicates whether this `ActivityType` is still active
    @Published var isActive: Bool = false
    /// Stores the color of this `ActivityType`
    @Published var color: Color = Color(red: .random(in: 0...1),
                                        green: .random(in: 0...1),
                                        blue: .random(in: 0...1))
    /// The name of the image associated with this `ActivityType`
    @Published var imageName: String = ""
    /// The optional start time of the last `TimeInterval` associated with this `ActivityType` (nil indicating there is no such `TimeInterval`)
    @Published var lastStartTime: Date? = nil
    /// The optional end time of the last `TimeInterval` associated with this `ActivityType` (nil indicating there is no such `TimeInterval` or it's not finished yet)
    @Published var lastEndTime: Date? = nil
    /// Display the duration (for format, see `TimeDisplayer` implementation) of the last associated `TimeInterval`
    @Published var timePassed: TimeDisplayer? = TimeDisplayer()
    /// Display the total cumulative duration of all `TimeInterval`s associated with this `ActivityType`
    @Published var totalTimePassed: TimeDisplayer = TimeDisplayer()
    
    
    // ID and connections
    /// The unique identity of the `ActivityType`
    var id: ActivityType.ID
    /// The `Model` to read the `ActivityType` from
    @ObservedObject var model: Model
    
    /// A timer used to refresh the `ActivityTypeCell` every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /// - Parameters:
    ///     - model: The `Model` to read the `ActivityType` from
    ///     - id: The stable identity of the `ActivityType`
    init(_ model: Model, id: ActivityType.ID) {
        self.model = model
        self.id = id
        
        updateStates()
    }
    
    /// Update the `ActivityType` state for this ViewModel
    private func updateStates() {
        guard let activity = model.activityType(id) else {
            return
        }
        
        // visual management
        self.name = activity.name
        self.isActive = activity.isActive
        self.color = activity.color
        self.imageName = activity.imageName
        
        // time management
        (self.lastStartTime, self.lastEndTime) = model.latestIntervalTimes(of: id)
        updateTimePassed()
    }
    
    /// Toggle the `ActivityType`'s isActive property
    func toggleActivityType() {
        isActive.toggle()
        model.toggleActivityType(with: id)
    }
    
    /// Re-calculate how much time has passed in the associated `TimeInterval`
    /// If no associated `TimeInterval` was found (= no lastStartTime was determined), return nil
    func updateTimePassed() {
        guard let lastStartTime = lastStartTime else {
            self.timePassed = nil
            return
        }
        
        // FIXME: move logic to model?
        self.timePassed = TimeDisplayer(secondsPassed: isActive ? Date().timeIntervalSince(lastStartTime) : lastEndTime!.timeIntervalSince(lastStartTime))
        
        self.totalTimePassed = TimeDisplayer(secondsPassed: model.cumulativeIntervalTimes(of: id))
    }
}
