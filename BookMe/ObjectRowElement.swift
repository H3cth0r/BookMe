//
//  ObjectRowElement.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit


// https://medium.com/@tapkain/custom-uiview-in-swift-done-right-ddfe2c3080a

class ObjectRowElement: UIView {
    
    var objName = "Object"
    var objImageName = "lightGreen"
    var objType = "Software"
    
    
    lazy var objectName: UILabel! = {
        let objectName = UILabel(frame: CGRect(x: 33, y: 8, width: 68, height: 63))
        objectName.font = UIFont(name: "Chivo-Bold", size: 15)
        objectName.text = objName
        objectName.textAlignment = .left
        objectName.textColor = .black
        objectName.numberOfLines = 2
        return objectName
    }()
    lazy var bookMeButton: UIButton! = {
        let bookMeButton = UIButton(type: .custom)
        bookMeButton.frame = CGRect(x: 312, y: 24, width: 80, height: 31)
        bookMeButton.setImage(UIImage(named: "BooKMeButton"), for: .normal)
        bookMeButton.setTitle("", for: .normal)
        bookMeButton.tintColor = .black
        bookMeButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        return bookMeButton
    }()
    lazy var disponibility: UILabel! = {
        let disponibility = UILabel(frame: CGRect(x: 132, y: 33, width: 98, height: 21))
        disponibility.font = UIFont(name: "Chivo-Light", size: 14)
        disponibility.text = "Available"
        disponibility.textAlignment = .left
        disponibility.textColor = .black
        return disponibility
    }()
    lazy var statusLight: UIImageView! = {
        let statusLight = UIImageView(frame: CGRect(x: 273, y: 39, width: 9, height: 9))
        statusLight.image = UIImage(named: objImageName)
        return statusLight
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
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .white
        objectName.text = objName
        //bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        bookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(bookMeButton)
        addSubview(objectName)
        addSubview(disponibility)
        addSubview(statusLight)
        
    }
    
    @objc func buttonClicked(sender: UIButton!){
        print("lol")
        if objType == "Software"{
            print("Type software")
        }else if objType == "Hardware"{
            print("Type hardware")
        }else{
            print("Type space")
        }
        
    }
    
    
    
    

}
