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
    @ObservedObject private var viewModel: ActivityTypeCellViewModel

    // Visual constants
    /// The standard color for the inactive `ActivityTypeCell`
    private var inactiveColor: Color = .secondary
    /// The radius of corners used to display the `ActivityTypeCell`
    private var cornerRadius: CGFloat = 20
    /// The frame size used to display the border and image of `ActivityTypeCell`
    private var borderFrameSize: CGFloat = 65
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

            // TODO: work on fonts to make everything more proportional

            // display the latest time interval associated with this ActivityType
            // if active, only the start time is shown, e.g. "1:15 PM -"
            // else, if at least one TimeInterval exists (= startTime is not nil) both start and end times are shown, e.g. "1:15 PM - 3:00 PM"
            // otherwise, an empty text is shown
            if viewModel.isActive, let lastStartTime = viewModel.lastStartTime {
                Text("\(DateFormatter.onlyTime.string(from: lastStartTime)) - ")
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
            } else if let lastStartTime = viewModel.lastStartTime, let lastEndTime = viewModel.lastEndTime {
                Text("\(DateFormatter.onlyTime.string(from: lastStartTime)) - \(DateFormatter.onlyTime.string(from: lastEndTime))")
                    .foregroundColor(.secondary)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
            } else {
                Text("-")
            }
        }
    }

    /// A view displaying timer and total time
    private var timeDisplay: some View {
        // TODO replace with real values from the viewmodel
        VStack(alignment: .trailing) {
            Text(viewModel.totalTimePassed.description).bold()
            Text(viewModel.timePassed?.description ?? "")
        }.onReceive(viewModel.timer) { _ in
            viewModel.updateTimePassed()
        }
    }

    /// A view displaying the background of this `ActivityTypeCell`
    private var activityTypeBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: lineWidth)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(gradient:
                                        Gradient(colors: [
                                                    viewModel.isActive ? viewModel.color.opacity(activeLeadingOpacity) : inactiveColor.opacity(inactiveLeadingOpacity),
                                                    viewModel.isActive ? viewModel.color.opacity(activeTrailingOpacity) : inactiveColor.opacity(inactiveTrailingOpacity)]
                                        ),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
            )
            .frame(height: borderFrameSize)
    }

    /// A view displaying the foreground (text/icon/time) of this `ActivityTypeCell`
    private var activityTypeForeground: some View {
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
                activityTypeBackground
                activityTypeForeground
                    .padding([.leading, .trailing])
            }
        }.foregroundColor(.primary)
    }

    /// - Parameters:
    ///     - model: The `Model` to read the `ActivityType` from
    ///     - id: The stable identity of the `ActivityType`
    init(_ model: Model, id: ActivityType.ID) {
        viewModel = ActivityTypeCellViewModel(model, id: id)
    }
}

// MARK: - ActivityTypeCell Previews
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
