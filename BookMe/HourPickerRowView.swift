//
//  HourPickerRowView.swift
//  BookMe
//
//  Created by Héctor Miranda García on 24/09/22.
//

import UIKit

class HourPickerRowView: UIView {
    
    var occupied = false
    
    lazy var occupiedRow: UIView! = {
        let occupiedRow = UIView()
        occupiedRow.frame = CGRect(x: 42, y: 10, width: 12, height: 33.5)
        occupiedRow.heightAnchor.constraint(equalToConstant:33.5).isActive = true
        occupiedRow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        occupiedRow.backgroundColor = .gray
        occupiedRow.isHidden = false
        return occupiedRow
    }()
    
    lazy var occupyRow: UIView! = {
        let occupyRow = UIView()
        occupyRow.frame = CGRect(x: 167, y: 10, width: 12, height: 33.5)
        occupyRow.heightAnchor.constraint(equalToConstant:33.5).isActive = true
        occupyRow.widthAnchor.constraint(equalToConstant: 12).isActive = true
        occupyRow.backgroundColor = .white
        occupyRow.isHidden = false
        return occupyRow
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
        occupied = false
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(occupiedRow)
        addSubview(occupyRow)
        
    }

}
