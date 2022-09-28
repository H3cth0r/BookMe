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
    
    func hourToString(){
        var h = String(self.hour)
        var m = String(self.minute)
        if(h.count == 1){
            h = "0" + h
        }
        if(m.count == 1){
            m = "0" + m
        }
        self.stringHour = h + "." + m
    }
}
