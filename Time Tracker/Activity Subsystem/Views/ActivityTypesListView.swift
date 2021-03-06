//
//  ActivitiesListView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import SwiftUI

// MARK: - ActivityTypesListView
/// A view representing a list of `ActivityType`s
struct ActivityTypesListView: View {
    /// The ViewModel to manage the logic of this `ActivityTypesListView`
    @ObservedObject private var viewModel: ActivityTypesListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.activityTypes) { activity in
                    ActivityTypeCell(viewModel.model, id: activity.id)
                        .padding([.trailing, .leading], 10)
                }
            }
            .padding(.top, 10)
            .navigationBarTitle("Activities", displayMode: .inline)
            .toolbar {
                // TODO add functionality
                Button(action: { }) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    /// - Parameters:
    ///     - model: The `Model` to read `ActivityType`s from
    init(_ model: Model) {
        viewModel = ActivityTypesListViewModel(model)
    }
}

// MARK: - ActivityTypesListView Previews
struct ActivityTypesListView_Previews: PreviewProvider {
    private static var model = MockModel()

    static var previews: some View {
        Group {
            ActivityTypesListView(model)
                .preferredColorScheme(.light)
            ActivityTypesListView(model)
                .preferredColorScheme(.dark)
        }
        .environmentObject(model as Model)
    }
}
