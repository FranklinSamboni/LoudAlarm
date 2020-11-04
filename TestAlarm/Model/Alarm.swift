//
//  Alarm.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import Foundation
import UserNotifications

class Alarm: Codable {

    let id: Double
    var name: String
    var description: String?
    var enabled: Bool
    var date: Date
    var notificationIds: Set<String>
    
    init(id: Double, name: String, description: String?, enabled: Bool, date: Date, notificationIds: Set<String>) {
        self.id = id
        self.name = name
        self.description = description
        self.enabled = enabled
        self.date = date
        self.notificationIds = notificationIds
    }
    
    func getFormattedHour() -> String {
        return date.dateFormatted(format: "h:mm a")
    }
    
    func getFormattedDate() -> String {
        return date.dateFormatted(format: "d 'de' MMMM yyyy")
    }
}

extension Alarm: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.id == rhs.id
    }
}
