//
//  TaskCellViewModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import Foundation
import SwiftUI

// MARK: - ActivityCellViewModel
/// A ViewModel for the `ActivityCell`
class AcitivityCellViewModel: ObservableObject {
    // State properties
    /// The name of this `Activity`
    @Published var name: String = ""
    /// Indicates whether this `Activity` is still active
    @Published var isActive: Bool = false
    /// Stores the color of this `Activity`
    @Published var color: Color = Color(red: .random(in: 0...1),
                                        green: .random(in: 0...1),
                                        blue: .random(in: 0...1))
    /// The name of the image associated with this `Activity`
    @Published var imageName: String = ""
    
    
    // ID and connections
    /// The unique identity of the `Activity`
    var id: Activity.ID
    /// The `Model` to read the `Activity` from
    @ObservedObject var model: Model
    
    
    /// - Parameters:
    ///     - model: The `Model` to read the `Activity` from
    ///     - id: The stable identity of the `Activity`
    init(_ model: Model, id: Activity.ID) {
        self.model = model
        self.id = id
        
        updateStates()
    }
    
    /// Update the `Activity` state for this ViewModel
    private func updateStates() {
        guard let activity = model.activity(id) else {
            return
        }
        
        self.name = activity.name
        self.isActive = activity.isActive
        self.color = activity.color
        self.imageName = activity.imageName
    }
    
    /// Toggle the `Activity`'s isActive property
    func toggleActivity() {
        isActive.toggle()
        model.toggleActivity(with: id)
    }
}
