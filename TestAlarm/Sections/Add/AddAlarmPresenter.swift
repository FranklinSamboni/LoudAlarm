//
//  AddAlarmPresenter.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import Foundation


class AddAlarmPresenter {
    
    let alarmRepository = AlarmRepository()
    let scheduleNotifications = ScheduleNotificationsRepository()
    
    var alarm: Alarm?
    
    init(alarm: Alarm?) {
        self.alarm = alarm
    }
    
    func saveAlarm(title: String, description: String?, date: Date) {
        
        let notificationsIds = scheduleNotifications.schedule(title: title, body: description, date: date)
        
        if let alarm = alarm {
            alarm.name = title
            alarm.description = description
            alarm.date = date
            alarm.notificationIds = notificationsIds
            alarm.enabled = true
            
        } else {
            alarm = Alarm(id: Date().timeIntervalSince1970,
                          name: title,
                          description: description,
                          enabled: true,
                          date: date,
                          notificationIds: notificationsIds)
        }

        alarmRepository.save(alarm: alarm!)
    }
    
    func removeAlarm() {
        if let alarm = alarm {
            scheduleNotifications.cancelNotifications(ids: alarm.notificationIds)
            alarmRepository.delete(alarm: alarm)
        }
    }
}
