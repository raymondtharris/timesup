//
//  Alarm.swift
//  timesup
//
//  Created by Tim Harris on 2/7/18.
//  Copyright © 2018 Tim Harris. All rights reserved.
//

import Foundation


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
    var alarmTime:Timer? = nil
    var state: AlarmState = .off
    var doesRepeat: Bool = false
    var daysToRepeat: Queue<AlarmRepeat> = Queue()
}
