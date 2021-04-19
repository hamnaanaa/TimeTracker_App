//
//  ContentView.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            ActivityTypesListView(model)
                .tabItem { Image(systemName: "timelapse") }
            TimeIntervalsListView(model)
                .tabItem { Image(systemName: "timer") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    private static var model = MockModel()
    
    static var previews: some View {
        MainView()
            .environmentObject(model as Model)
    }
}
