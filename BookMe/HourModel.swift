//
//  HourModel.swift
//  BookMe
//
//  Created by Héctor Miranda García on 24/09/22.
//

import Foundation


class HourModel{
    var hour: Int
    var minute: Int
    var occupied: Bool
    var occupy: Bool
    var stringHour: String
    
    init (hour: Int, minute: Int, occupied: Bool, occupy: Bool){
        self.hour = hour
        self.minute = minute
        self.occupied = occupied
        self.occupy = occupy
        self.stringHour = String(hour) + ":"  + String(minute)
    }
}
