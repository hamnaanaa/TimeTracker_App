//
//  ActivitiesListView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import SwiftUI

// TODO description
struct ActivityTypesListView: View {
    @EnvironmentObject var model: Model
    @ObservedObject var viewModel: ActivityTypesListViewModel
    
    
    var body: some View {
        NavigationView {
            List(viewModel.activityTypes) { activity in
                ActivityTypeCell(model, id: activity.id)
            }.navigationBarTitle("Today", displayMode: .inline)
            .toolbar {
                // TODO add functionality
                Button(action: { }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    
    init(_ model: Model) {
        viewModel = ActivityTypesListViewModel(model)
    }
}

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