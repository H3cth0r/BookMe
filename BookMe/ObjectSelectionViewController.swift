//
//  ObjectSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit

class ObjectSelectionViewController: UIViewController {
    

    @IBOutlet var vwContainer: UIView!
    
    @IBOutlet weak var objRowvr: UIStackView!
    
    @IBOutlet weak var typeObjectTitle: UILabel!
    var theTypeOfObject = ""
    
    var reservation = ReservationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        stackViewRows.leadingAnchor.constraint(equalTo: self.scrollViewObjects.leadingAnchor).isActive = true
        stackViewRows.trailingAnchor.constraint(equalTo:stackViewRows.trailingAnchor).isActive=true
        stackViewRows.topAnchor.constraint(equalTo:stackViewRows.topAnchor).isActive=true
        stackViewRows.bottomAnchor.constraint(equalTo:stackViewRows.bottomAnchor).isActive=true
        
        stackViewRows.widthAnchor.constraint(equalTo:self.view.widthAnchor).isActive=true
         */
        // https://stackoverflow.com/questions/55817614/how-to-set-an-empty-uistackview-inside-a-uiscrollview-so-that-i-can-fill-it-on-r

        typeObjectTitle.text = theTypeOfObject
        
        objRowvr.axis = .vertical
        objRowvr.distribution = .fillEqually
        objRowvr.spacing = 0
        objRowvr.distribution = .fill
        objRowvr.alignment = .fill
        
        
        var roomsTitleName: [String] = ["Sala de redes: CDT101",
                                        "Sala de redes: CDT201",
                                        "Sala: CDT301",
                                        "Sala: CDT401"]
        var softwareTitleName: [String] = ["Software: Adobe XD",
                                           "Software: Autocad",
                                           "Software: Blender",
                                           "Software: VIM",
                                           "Software: Inkscape",
                                           "Software: Figma",
                                           "Software: Terminal",
                                           "Software: Ubuntu",
                                           "Software: Word",
                                           "Software: AutoDesk",
                                           "Software: Powerpoint",
                                           "Software: Excel",
                                           "Software: Android"]
        var hardwareTitleName: [String] = ["Hardware: Mac",
                                           "Hardware: Iphone",
                                           "Hardware: Radio",
                                           "Hardware: Rocket",
                                           "Hardware: Clock",
                                           "Hardware: Server",
                                           "Hardware: Keyboard",
                                           "Hardware: Mouse",
                                           "Hardware: Ipad",
                                           "Hardware: Plane",
                                           "Hardware: Microwave",
                                           "Hardware: Arduino",
                                           "Hardware: Raspberry",
                                           "Hardware: Microchip"]
        var selectionList: [String] = []
        
        if(typeObjectTitle.text == "Space"){
            selectionList = roomsTitleName
        }else if(typeObjectTitle.text == "Hardware"){
            selectionList = hardwareTitleName
        }else{
            selectionList = softwareTitleName
        }
        
        for i in selectionList{
            let one = ObjectRowElement()
            //one.frame = CGRect(x: 0, y: 0, width: 414, height: 63)
            one.isUserInteractionEnabled = true
            one.objName = i
            one.heightAnchor.constraint(equalToConstant:55).isActive = true
            one.objType = typeObjectTitle.text!
            one.setupV()
            one.bookMeButton.addTarget(self, action: #selector(toNextBookingConfigView), for: .touchUpInside)
            objRowvr.addArrangedSubview(one)
        }
    }
    
    @objc func toNextBookingConfigView(sender: UIButton!) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjectDescriptionViewController") as! ObjectDescriptionViewController
            vc.theTypeOfObject = self.theTypeOfObject
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func toMainMenuButton(_ sender: Any) {
        // To Main Menu after some time
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
