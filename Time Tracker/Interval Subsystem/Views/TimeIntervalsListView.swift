//
//  TimeIntervalsListView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 19.04.21.
//

import SwiftUI

// MARK: - TimeIntervalsListView
/// A view representing a list of `TimeInterval`s
struct TimeIntervalsListView: View {
    /// The ViewModel to manage the logic of this `TimeIntervalsListView`
    @ObservedObject private var viewModel: TimeIntervalsListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.timeIntervals) { timeInterval in
                    TimeIntervalCell(viewModel.model, id: timeInterval.id)
                }
                .onDelete(perform: viewModel.delete(at:))
            }
            .navigationBarTitle("History", displayMode: .inline)
            .toolbar {
                // TODO add functionality
                Button(action: { }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    init(_ model: Model) {
        viewModel = TimeIntervalsListViewModel(model)
    }
}

struct TimeIntervalsListView_Previews: PreviewProvider {
    private static var model = MockModel()
    
    static var previews: some View {
        Group {
            TimeIntervalsListView(model)
                .preferredColorScheme(.light)
            TimeIntervalsListView(model)
                .preferredColorScheme(.dark)
        }
        .environmentObject(model as Model)
    }
}
