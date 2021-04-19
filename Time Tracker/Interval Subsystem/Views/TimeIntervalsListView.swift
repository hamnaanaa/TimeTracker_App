//
//  TimeIntervalsListView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 19.04.21.
//

import SwiftUI

// MARK: - TODO
struct TimeIntervalsListView: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(_ model: Model) {
        // TODO
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
