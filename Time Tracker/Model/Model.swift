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
    @Published var storedActivities: [Activity]
    /// All available `Activity` names
//    @Published var allActivityNames: [String]
    
    /// - Parameters:
    ///     - storedActivities: All `Activity` entries stored as a list
    ///     - allActivityNames: All available `Activity` names
    init(storedActivities: [Activity] = [], allActivityNames: [String] = []) {
        self.storedActivities = storedActivities
//        self.allActivityNames = allActivityNames
    }
    
    /// Get an `Activity` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `Activity`  to find
    /// - Returns: The corresponding `Activity` if there exists one with the specified id, otherwise nil
    func activity(_ id: Activity.ID) -> Activity? {
        storedActivities.first { $0.id == id }
    }
    
    /// Change the `Activity`'s state by toggling its isActive property
    /// - Parameters:
    ///    - id: The id of the `Activity` to update
    func toggleActivity(of id: Activity.ID) {
        guard let index = storedActivities.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        storedActivities[index].toggle()
    }
}
