//
//  Application.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 4/11/20.
//

import Foundation
import UserNotifications

class Application {
    
    static let shared = Application()
    
    private init () {}
    
    var localNotification: UNNotification?
}
