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
    
    /// List of all `TimeInterval`s to display
    @Published var timeIntervals: [TimeInterval] = []
    
    init(_ model: Model) {
        self.model = model
        
        updateState()
    }
    
    private func updateState() {
        // TODO: see if this is enough when the edit functionality is implemented
        self.timeIntervals = model.timeIntervals.sorted()
    }
    
    /// Deletes the `TimeInterval` at the given index set in the `TimeIntervalsListView`
    /// - Parameters:
    ///     - indexSet: The index set of the View in the `TimeIntervalsListView` that should be deleted
    func delete(at indexSet: IndexSet) {
        indexSet
            .map { timeIntervals[$0].id }
            .forEach { model.delete(timeInterval: $0) }
    }
}
