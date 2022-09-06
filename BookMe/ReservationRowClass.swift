//
//  ReservationRowClass.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class ReservationRowClass: UIView {
    
    var objName = "Software: Adobe XD"
    var objQrCode = ""
    var startdt = "SEPT 04TH 10:00 AM"
    var enddt = "SEPT 04TH 11:00 AM"
    var objType = "Software"
    
    lazy var objectName: UILabel! = {
        let objectName = UILabel(frame: CGRect(x: 20, y: 13, width: 87, height: 42))
        objectName.font = UIFont(name: "Chivo-Bold", size: 15)
        objectName.text = objName
        objectName.textAlignment = .left
        objectName.textColor = .black
        objectName.numberOfLines = 2
        return objectName
    }()
    
    lazy var startDate: UILabel! = {
        let startDate = UILabel(frame: CGRect(x: 122, y: 13, width: 130, height: 16))
        startDate.font = UIFont(name: "Chivo-Regular", size: 13)
        startDate.text = startdt
        startDate.textAlignment = .left
        startDate.textColor = .black
        startDate.numberOfLines = 2
        return startDate
    }()
    
    lazy var endDate: UILabel! = {
        let endtDate = UILabel(frame: CGRect(x: 122, y: 39, width: 130, height: 416))
        endDate.font = UIFont(name: "Chivo-Regular", size: 13)
        endDate.text = enddt
        endDate.textAlignment = .left
        endDate.textColor = .black
        endDate.numberOfLines = 2
        return endtDate
    }()
    
/*
 
    HERE CREATE THE BUTTON OF THE QR OBJECT
 */
    
/*
    HERE CREATE THE BUTTON OF THE DELETE BUTTON
 */

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
