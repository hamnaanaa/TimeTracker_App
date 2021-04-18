//
//  ActivitiesListViewModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import Foundation
import SwiftUI

// MARK: - TODO
class ActivitiesListViewModel: ObservableObject {
    //TODO
    /// The `Model` to read the list of `Activity`s from
    @ObservedObject var model: Model
    
    @Published var activities: [Activity] = []
    
    init(_ model: Model) {
        self.model = model
        
        updateState()
    }
    
    private func updateState() {
        self.activities = model.storedActivities
    }
}
