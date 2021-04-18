//
//  MockModel.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 18.04.21.
//

import Foundation
import SwiftUI

// MARK: - MockModel
/// A `Model` that replaces the content of the Time Tracker App with a predefined set of elements every time it is initialized
class MockModel: Model {
    private static func createActivity(_ name: String, color: Color, isActive: Bool, imageName: String = "record.circle") -> Activity {
        Activity(name: name,
                 color: color,
                 isActive: isActive,
                 imageName: imageName)
    }
    
    convenience init() {
        let allActivities = [
            MockModel.createActivity("Free time", color: .green, isActive: true, imageName: "face.smiling"),
            MockModel.createActivity("Work", color: .blue, isActive: true),
            MockModel.createActivity("Food", color: .yellow, isActive: true),
            MockModel.createActivity("Productivity", color: .purple, isActive: true, imageName: "building.columns"),
            MockModel.createActivity("Groceries", color: .red, isActive: false),
            MockModel.createActivity("Sleep", color: .orange, isActive: false)
        ]
        
        self.init(storedActivities: allActivities)
    }
}
