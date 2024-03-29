//
//  Alarm.swift
//  timesup
//
//  Created by Tim Harris on 2/7/18.
//  Copyright © 2018 Tim Harris. All rights reserved.
//

import Foundation
import UserNotifications


enum AlarmState {
    case on
    case off
}
enum AlarmRepeat {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

struct Alarm {
    var name = ""
	var alarmHour:Int = 0
	var alarmMinute:Int = 0
	var alarmTimeOfDay:AMPM = .AM
    var state: AlarmState = .off
    var doesRepeat: Bool = false
    var daysToRepeat: Queue<AlarmRepeat> = Queue()
    var currentNotification:UNNotificationRequest? = nil
    
    mutating func repeatNext() -> Void {
        
        let lastRepeated = daysToRepeat.Dequeue()
        daysToRepeat.Enqueue(newNode: Node(newValue: lastRepeated!.value))
    }
    
}
