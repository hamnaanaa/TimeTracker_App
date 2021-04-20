//
//  TimeIntervalsListViewModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 20.04.21.
//

import Foundation
import SwiftUI

// MARK: - TimeIntervalsListViewModel
/// A ViewModel for the `TimeIntervalsListView`
class TimeIntervalsListViewModel: ObservableObject {
    /// The `Model` to read the list of `TimeInterval`s from
    @ObservedObject var model: Model
    
    @Published var timeIntervals: [TimeInterval] = []
    
    init(_ model: Model) {
        self.model = model
        
        updateState()
    }
    
    private func updateState() {
        self.timeIntervals = model.timeIntervals
    }
}
