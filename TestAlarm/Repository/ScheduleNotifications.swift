//
//  ScheduleNotifications.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import UserNotifications

class ScheduleNotificationsRepository {
    
    let MAX_NOTIFICATIONS = 40
    let NOTIFICATION_DELAY_INTERVAL = 5 // seconds
    
    func schedule(title: String, body: String?, date: Date) -> Set<String> {
        var notificationsIds: Set<String> = []
        
        for i in 0..<MAX_NOTIFICATIONS {
            let id = scheduleNotification(number: i, title: title, body: body, date: date)
            notificationsIds.insert(id)
        }
        return notificationsIds
    }
    
    func cancelNotifications(ids: Set<String>) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: Array(ids))
    }
    
    private func scheduleNotification(number: Int, title: String, body: String?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body ?? ""
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Weckersound.mp3"))
        
        let nextInterval = TimeInterval(number * NOTIFICATION_DELAY_INTERVAL)
        let scheduleDate = date.addingTimeInterval(nextInterval)
        let components: Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second,]
        let triggerDate = Calendar.current.dateComponents(components, from: scheduleDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        }
        return uuidString
    }
}
