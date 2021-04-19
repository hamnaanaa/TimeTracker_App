//
//  TaskCell.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 17.04.21.
//

import SwiftUI

// MARK: - ActivityTypeCell
/// A view (activity cell) representing a single `ActivityTypeCell`
struct ActivityTypeCell: View {
    /// The ViewModel to manage the logic of this `ActivityTypeCell`
    @ObservedObject private var viewModel: AcitivityTypeCellViewModel
    
    // Visual constants
    /// The standard color for the inactive `ActivityTypeCell`
    private var inactiveColor: Color = .secondary
    /// The radius of corners used to display the `ActivityTypeCell`
    private var cornerRadius: CGFloat = 20
    /// The frame size used to display the border and image of `ActivityTypeCell`
    private var borderFrameSize: CGFloat = 75
    private var imageFrameSize: CGFloat = 35
    /// The opacities used for the gradient of background's color of the `ActivityTypeCell` depending on state
    private var activeLeadingOpacity: Double = 1.0
    private var activeTrailingOpacity: Double = 0.3
    private var inactiveLeadingOpacity: Double = 0.4
    private var inactiveTrailingOpacity: Double = 0.1
    /// The stroke width of the line used as a border for this `ActivityTypeCell`
    private var lineWidth: CGFloat = 2
    
    
    /// A view displaying the name of the `ActivityType` and the timeline
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
    
    /// A view representing the background of this `ActivityTypeCell`
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
    
    /// A view representing the foreground (text/icon/time) of this `ActivityTypeCell`
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
        Button(action: { viewModel.toggleActivityType() }) {
            ZStack {
                activityBackground
                activityForeground
                    .padding()
            }
        }.foregroundColor(.primary)
    }
    
    
    /// - Parameters:
    ///     - model: The `Model` to read the `ActivityType` from
    ///     - id: The stable identity of the `ActivityType`
    init(_ model: Model, id: ActivityType.ID) {
        viewModel = AcitivityTypeCellViewModel(model, id: id)
    }
}

struct ActivityTypeCell_Previews: PreviewProvider {
    private static var model = MockModel()
    // different color schemes to test
    private static var colorSchemes = [ColorScheme.light, .dark]
    
    static var previews: some View {
        Group {
            ForEach(model.activityTypes) { activity in
                ForEach(colorSchemes, id: \.hashValue) { colorScheme in
                    ActivityTypeCell(model, id: activity.id)
                        .preferredColorScheme(colorScheme)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
