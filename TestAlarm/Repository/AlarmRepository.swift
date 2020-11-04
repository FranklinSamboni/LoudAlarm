//
//  AlarmRepository.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import Foundation

class AlarmRepository {
    
    let ALARMS_KEY = "ALARMS_KEY"
    let defaults = UserDefaults.standard
    
    func getAlarms() -> Set<Alarm> {
        do {
            guard let data = defaults.object(forKey: ALARMS_KEY) as? Data else { return [] }
            let set: Set<Alarm> = try Set<Alarm>.toModel(data: data)
            return set
        } catch {
            print(error)
        }
        return []
    }
    
    func save(alarm: Alarm) {
        var alarms = getAlarms()
        let (inserted, old) = alarms.insert(alarm)
        if !inserted {
            alarms.remove(old)
            alarms.insert(alarm)
        }
        
        updateSet(alarms: alarms)
    }
    
    func delete(alarm: Alarm) {
        var alarms = getAlarms()
        alarms.remove(alarm)
        
        updateSet(alarms: alarms)
    }
    
    private func updateSet(alarms: Set<Alarm>) {
        let data = alarms.asData()
        defaults.set(data, forKey: ALARMS_KEY)
    }
}
