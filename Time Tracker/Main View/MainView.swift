//
//  ContentView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        TabView {
            ActivityTypesListView(model)
                .tabItem { Image(systemName: "timelapse") }
            TimeIntervalsListView(model)
                .tabItem { Image(systemName: "timer") }
        }
        // TODO: add support of different colors
        .navigationBarColor(backgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                            tintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

    }
}

struct MainView_Previews: PreviewProvider {
    private static var model = MockModel()
    
    static var previews: some View {
        Group {
            MainView().preferredColorScheme(.light)
            MainView().preferredColorScheme(.dark)
        }
            .environmentObject(model as Model)
    }
}
