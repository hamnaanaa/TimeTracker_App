//
//  ActivitiesListView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import SwiftUI

// TODO description
struct ActivitiesListView: View {
    @EnvironmentObject var model: Model
    @ObservedObject var viewModel: ActivitiesListViewModel
    
    var body: some View {
        List(viewModel.activities) { activity in
            ActivityCell(model, id: activity.id)
        }
    }
    
    init(_ model: Model) {
        viewModel = ActivitiesListViewModel(model)
    }
}

struct ActivitiesListView_Previews: PreviewProvider {
    private static var model = MockModel()
    
    static var previews: some View {
        Group {
            ActivitiesListView(model)
                .preferredColorScheme(.light)
            ActivitiesListView(model)
                .preferredColorScheme(.dark)
        }
        .environmentObject(model as Model)
    }
}
