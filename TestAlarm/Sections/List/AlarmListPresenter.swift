//
//  AlarmListPresenter.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import Foundation

class AlarmListPresenter {
    
    private let repository = AlarmRepository()
    private let scheduleNotifications = ScheduleNotificationsRepository()
    
    private weak var alarmListView: AlarmListView?
    
    func getAlarms() -> [Alarm] {
        let alarmsSet = repository.getAlarms()
        var alarms = Array(alarmsSet)
        alarms.sort(by: { $0.id > $1.id })
        return alarms
    }
    
    func deleteAlarm(alarm: Alarm) {
        repository.delete(alarm: alarm)
    }
    
    func enableAlarm(alarm: Alarm) {
        alarm.enabled = true
        let notificationsIds = scheduleNotifications.schedule(title: alarm.name, body: alarm.description, date: alarm.date)
        alarm.notificationIds = notificationsIds
        repository.save(alarm: alarm)
    }

    func disableAlarm(notificationId: String) {
        let alarms = getAlarms()
        guard let selectedAlarm = alarms.filter({ $0.notificationIds.contains(notificationId)}).first else {
            return
        }
        disableAlarm(alarm: selectedAlarm)
    }
    
    func disableAlarm(alarm: Alarm) {
        scheduleNotifications.cancelNotifications(ids: alarm.notificationIds)
        alarm.enabled = false
        repository.save(alarm: alarm)
    }
}
