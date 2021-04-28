//
//  TimeIntervalCell.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 19.04.21.
//

import SwiftUI

// MARK: - TimeIntervalCell
/// A view representing a single `TimeInterval`
struct TimeIntervalCell: View {
    /// The ViewModel to manage the logic of this `TimeIntervalCell`
    @ObservedObject private var viewModel: TimeIntervalCellViewModel

    // Visual constants
    /// The standard color for the active `TimeIntervalCell`
    private var activeColor: Color = .blue
    /// The radius of corners used to display the `TimeIntervalCell`
    private var cornerRadius: CGFloat = 20
    /// The frame size used to display the border and image of `TimeIntervalCell`
    private var borderFrameSize: CGFloat = 75
    private var imageFrameSize: CGFloat = 35
    /// The stroke width of the line used as a border for this `TimeIntervalCell`
    private var lineWidth: CGFloat = 2
    /// The padding of the image to both top and bottom or edge for this `TimeIntervalCell`
    private var imageVerticalPadding: CGFloat = 5
    private var imageEdgePadding: CGFloat = 7

    /// A view displaying the name of the `ActivityType` associated with this `TimeInterval`
    private var description: some View {
        VStack(alignment: .leading) {
            Text(viewModel.associatedActivityType?.name ?? "?")
                .foregroundColor(viewModel.isActive ? activeColor : .primary)
                .minimumScaleFactor(0.1)
                .scaledToFit()

            // if active, only the start time is shown, e.g. "1:15 PM -"
            // else, both start and end times are shown, e.g. "1:15 PM - 3:00 PM"
            if viewModel.isActive {
                Text("\(DateFormatter.onlyTime.string(from: viewModel.startTime)) - ")
                    .foregroundColor(activeColor)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
            } else {
                Text("\(DateFormatter.onlyTime.string(from: viewModel.startTime)) - \(DateFormatter.onlyTime.string(from: viewModel.endTime!))")
                    .foregroundColor(.secondary)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
            }
        }
    }

    /// A view displaying the timer
    private var timeDisplay: some View {
        // TODO replace with real time
        Text(viewModel.timePassed.description)
            .foregroundColor(viewModel.isActive ? activeColor : .primary)
            .font(.title3)
            .padding(.trailing, 7)
            .onReceive(viewModel.timer) { _ in
                viewModel.updateTimePassed()
            }
    }

    /// A view displaying the foreground of this `TimeIntervalCell`
    private var timeIntervalForeground: some View {
        HStack(spacing: 10) {
            // question mark identifies that something went wrong
            // with linking this timeInterval to associatedActivityType
            Image(systemName: viewModel.associatedActivityType?.imageName ?? "questionmark")
                .resizable()
                .foregroundColor(viewModel.associatedActivityType?.color)
                .frame(width: imageFrameSize, height: imageFrameSize)
                .padding(.leading, imageEdgePadding)
                .padding(.bottom, imageVerticalPadding)
                .padding(.top, imageVerticalPadding)

            description
            Spacer()
            timeDisplay
        }
    }

    var body: some View {
        timeIntervalForeground
    }

    /// - Parameters:
    ///     - model: The `Model` to read the `TimeInterval` from
    ///     - id: The stable identity of the `ActivityType`
    init(_ model: Model, id: TimeInterval.ID) {
        viewModel = TimeIntervalCellViewModel(model, id: id)
    }
}

// MARK: - TimeIntervalCell Previews
struct TimeIntervalCell_Previews: PreviewProvider {
    private static var model = MockModel()
    // different color schemes to test
    private static var colorSchemes = [ColorScheme.light, .dark]

    static var previews: some View {
        Group {
            ForEach(model.timeIntervals) { timeInterval in
                ForEach(colorSchemes, id: \.hashValue) { colorScheme in
                    TimeIntervalCell(model, id: timeInterval.id)
                        .preferredColorScheme(colorScheme)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
