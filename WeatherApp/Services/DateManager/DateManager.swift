//
//  DateManager.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/10/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class DateManager: DateManagerProtocol {

    func getDefaultTimeFormat(from timeInterval: TimeInterval) -> String {
        getFormat(format: [.hour, .minute], interval: timeInterval)
    }
    
    func getHourTimeFormat(from timeInterval: TimeInterval) -> String {
        getFormat(format: [.hour], interval: timeInterval)
    }
    
    func getDayName(from timeInterval: TimeInterval) -> String {
                let date = Date(timeIntervalSince1970: timeInterval)
        let dayNumber = Calendar.current.component(.weekday, from: date)
        switch dayNumber {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return ""
        }
    }
    
    private func getFormat(format: [NSCalendar.Unit], interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour]
        let startOfDay = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: interval))
        return formatter.string(from: interval - startOfDay.timeIntervalSince1970) ?? ""
    }
}
