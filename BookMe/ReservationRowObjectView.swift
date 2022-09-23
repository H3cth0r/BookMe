//
//  ReservationRowObjectView.swift
//  BookMe
//
//  Created by Héctor Miranda García on 21/09/22.
//

import UIKit

class ReservationRowObjectView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var objType     = "Software"
    var objName     = "Object"
    var initialDate = "SEPT 04th 10:00 AM"
    var endDate     = "SEPT 16th 11:00 AM"
    

    
    lazy var objectName: UILabel! = {
        let objectName = UILabel(frame: CGRect(x: 41, y: 10, width: 86, height: 42))
        objectName.font = UIFont(name: "Chivo-Bold", size: 15)
        objectName.text = objName
        objectName.textAlignment = .left
        objectName.textColor = .black
        objectName.numberOfLines = 2
        //objectName.backgroundColor = .green
        return objectName
    }()
    lazy var initialDateLabel: UILabel! = {
        let initialDateLabel = UILabel(frame: CGRect(x: 137, y: 10, width: 145, height: 17))
        initialDateLabel.font = UIFont(name: "Chivo-Bold", size: 15)
        initialDateLabel.text = objName
        initialDateLabel.textAlignment = .left
        initialDateLabel.textColor = .black
        initialDateLabel.numberOfLines = 2
        //initialDateLabel.backgroundColor = .brown
        return initialDateLabel
    }()
    
    lazy var endDateLabel: UILabel! = {
        let endDateLabel = UILabel(frame: CGRect(x: 137, y: 36, width: 145, height: 17))
        endDateLabel.font = UIFont(name: "Chivo-Bold", size: 15)
        endDateLabel.text = objName
        endDateLabel.textAlignment = .left
        endDateLabel.textColor = .black
        endDateLabel.numberOfLines = 2
        //endDateLabel.backgroundColor = .cyan
        return endDateLabel
    }()
    
    
    lazy var qrCodeButton: UIButton!={
        let qrCodeButton = UIButton(type: .custom)
        qrCodeButton.frame = CGRect(x: 282, y: 0, width: 65, height: 65)
        qrCodeButton.setImage(UIImage(named: "miniQrCodeImage"), for: .normal)
        qrCodeButton.setTitle("", for: .normal)
        qrCodeButton.tintColor = .black
        //qrCodeButton.backgroundColor = .blue
        //qrCodeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return qrCodeButton
    }()
    
    lazy var deleteButton: UIButton!={
        let deleteButton = UIButton(type: .custom)
        deleteButton.frame = CGRect(x: 342, y: 0, width: 65, height: 65)
        deleteButton.setImage(UIImage(named: "deleteReservationLine"), for: .normal)
        deleteButton.setTitle("", for: .normal)
        deleteButton.tintColor = .black
        //deleteButton.backgroundColor = .purple
        return deleteButton
    }()
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      //setupView()
    }
    
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      //setupView()
    }
    
    func setupV(){
        setupView()
    }
    
    // common func to init our view
    private func setupView() {
        //frame = CGRect(x: 0, y: 0, width: 414, height: 63)
        objectName.text = objName
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        //qrCodeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(objectName)
        addSubview(initialDateLabel)
        addSubview(endDateLabel)
        addSubview(qrCodeButton)
        addSubview(deleteButton)
        
    }
    
    
    @objc func buttonClicked(sender: UIButton!){
        print("here!!!")
        
    }
    
}
