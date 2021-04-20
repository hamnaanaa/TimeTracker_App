//
//  CustomTimer.swift
//  Time Tracker
//
//  Created by Hamudi Naanaa on 20.04.21.
//

import Foundation

struct TimeDisplayer {
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    var showSeconds = false
    
    init(secondsPassed: Double = 0) {
        convertToTime(secondsPassed)
    }
    
    mutating func convertToTime(_ secondsPassed: Double, showSeconds: Bool = false) {
        self.hours = Int(secondsPassed) / 3600
        self.minutes = ((Int(secondsPassed) - (3600 * hours)) / 60)
        self.seconds = Int(secondsPassed) - (3600 * hours + 60 * minutes)
        
        self.showSeconds = showSeconds
    }
}

extension TimeDisplayer: CustomStringConvertible {
    var description: String {
        showSeconds ?
            "\(display(hours)):\(display(minutes)):\(display(seconds))" :
            hours == 0 && minutes == 0 ? "<1" : "\(display(hours)):\(display(minutes))"
    }
    
    private func display(_ time: Int) -> String {
        time > 9 ? "\(time)" : "0\(time)"
    }
}
