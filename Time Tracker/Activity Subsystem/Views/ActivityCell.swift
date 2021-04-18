//
//  TaskCell.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import SwiftUI

// MARK: - ActivityCell
/// A view (activity cell) representing a single `Activity`
struct ActivityCell: View {
    /// The ViewModel to manage the logic of this `ActivityCell`
    @ObservedObject private var viewModel: AcitivityCellViewModel
    
    // Visual constants
    /// The standard color for the inactive `ActivityCell`
    private var inactiveColor: Color = .secondary
    /// The radius of corners used to display the `ActivityCell`
    private var cornerRadius: CGFloat = 20
    /// The frame size used to display the border and image of `ActivityCell`
    private var borderFrameSize: CGFloat = 75
    private var imageFrameSize: CGFloat = 35
    /// The opacities used for the gradient of background's color of the `ActivityCell` depending on state
    private var activeLeadingOpacity: Double = 1.0
    private var activeTrailingOpacity: Double = 0.3
    private var inactiveLeadingOpacity: Double = 0.4
    private var inactiveTrailingOpacity: Double = 0.1
    /// The stroke width of the line used as a border for this `ActivityCell`
    private var lineWidth: CGFloat = 2
    
    /// A view displaying the name of the `Activity` and the timeline
    private var description: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .minimumScaleFactor(0.1)
                .scaledToFit()
            // TODO replace with real values from the viewmodel
            Text("6:55 pm - 11:55 pm")
                .minimumScaleFactor(0.5)
                .scaledToFit()
        }
    }
    
    /// A view displaying timer and total time
    private var timeDisplay: some View {
        // TODO replace with real values from the viewmodel
        VStack(alignment: .trailing) {
            Text("03:25").bold()
            Text("00:46")
        }
    }
    
    /// A view representing the background of this `ActivityCell`
    private var activityBackground: some View {
        // TODO: move to a separate view for better code readability?
        if viewModel.isActive {
            // active background
            return RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: lineWidth)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [viewModel.color.opacity(activeLeadingOpacity), viewModel.color.opacity(activeTrailingOpacity)]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                )
                .frame(height: borderFrameSize)
        } else {
            // inactive background
            return RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: lineWidth)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [inactiveColor.opacity(inactiveLeadingOpacity), inactiveColor.opacity(inactiveTrailingOpacity)]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                )
                .frame(height: borderFrameSize)
        }
    }
    
    /// A view representing the foreground (text/icon/time) of this `ActivityCell`
    private var activityForeground: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: imageFrameSize, height: imageFrameSize)
            description
            Spacer()
            timeDisplay
        }
    }
    
    var body: some View {
        Button(action: { viewModel.toggleActivity() }) {
            ZStack {
                activityBackground
                activityForeground
                    .padding()
            }
        }.foregroundColor(.primary)
    }
    
    /// - Parameters:
    ///     - model: The `Model` to read the `Activity` from
    ///     - id: The stable identity of the `Activity`
    init(_ model: Model, id: Activity.ID) {
        viewModel = AcitivityCellViewModel(model, id: id)
    }
}

struct ActivityCell_Previews: PreviewProvider {
    private static var model = MockModel()
    // different color schemes to test
    private static var colorSchemes = [ColorScheme.light, .dark]
    
    static var previews: some View {
        Group {
            ForEach(model.storedActivities) { activity in
                ForEach(colorSchemes, id: \.hashValue) { colorScheme in
                    ActivityCell(model, id: activity.id)
                        .preferredColorScheme(colorScheme)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
