//
//  DateCardObject.swift
//  BookMe
//
//  Created by Héctor Miranda García on 23/09/22.
//

import UIKit

class DateCardObject: UIView {
    
    var dateText = "TUESDAY 23TH AUGUST 2022"
    
    lazy var labelDate: UILabel! = {
        let labelDate = UILabel(frame: CGRect(x: 10, y: 10, width: 250, height: 250))
        labelDate.font = UIFont(name: "Chivo-Bold", size: 40)
        labelDate.text = dateText
        labelDate.textAlignment = .left
        labelDate.textColor = .black
        labelDate.numberOfLines = 5
        return labelDate
    }()
    
    lazy var selectDateButton: UIButton! = {
        let selectDateButton = UIButton(type: .custom)
        selectDateButton.frame = CGRect(x: 135, y: 355, width: 151, height: 50)
        selectDateButton.setImage(UIImage(named: "dateSelectButton"), for: .normal)
        selectDateButton.setTitle("", for: .normal)
        selectDateButton.tintColor = .black
        //bookMeButton.backgroundColor = .red // <----------
        //bookMeButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        return selectDateButton
    }()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
        labelDate.text = "TUESDAY 23TH AUGUST 2022"
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        selectDateButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(labelDate)
        addSubview(selectDateButton)
        
    }
    
    @objc func buttonClicked(sender: UIButton!){
        print("here")
    }

}
