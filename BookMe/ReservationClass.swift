//
//  ReservationClass.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import Foundation

class ReservationClass{
    
    // objects
    var hardwareObject: HardwareObject!
    var softwareObject: SoftwareObject!
    var roomObject: RoomObject!
    
    var recivedTicket: Ticket!
    
    var theTypeOfObject: String!
    
    // Multiple days reservation ?
    var multipleDays = false
    
    var objectTypeReservation = "Space"
    var objectName = "Room 1"
    
    // starting date
    var startDate = ""
    var startDateDay = ""
    var startDateDayNumber = ""
    var startDateMonth = ""
    var startDateYear = ""
    var startHour = ""
    var startDateFormat = ""
    
    var endDate = ""
    var endDateDay = ""
    var endDateDayNumber = ""
    var endDateMonth = ""
    var endDateYear = ""
    var endHour = ""
    var endDateFormat = ""
    
    var numberOfAssistants = 1
    
    
    // select object information
    var maxNumberOfAssistans = 1
    
}
