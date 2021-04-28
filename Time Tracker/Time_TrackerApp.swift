//
//  Time_TrackerApp.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import SwiftUI

@main
struct Time_TrackerApp: App {
    @StateObject var model: Model = MockModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(model)
        }
    }
}
