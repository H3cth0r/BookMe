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
    
    var selectionList: [String] = []
    var hardwareObjects: [HardwareObject]!
    var softwareObjects: [SoftwareObject]!
    var RoomObjects: [RoomObject]!
    
    // Here the reservation object that will be passed to each
    // view is created.
    var reservation = ReservationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reservationDataController = ReservationDataController()

        Task{
            if theTypeOfObject == "Software"{
                await reservationDataController.getSoftwarebjects(completion: { result in
                    for i in result{
                        print(i.name)
                    }
                    DispatchQueue.main.async {
                        self.setuptable(listOfObjects: result)
                    }
                })
            } else if theTypeOfObject == "Space"{
                await reservationDataController.getRoomobjects(completion: {result in
                    DispatchQueue.main.async {
                        self.setuptableSpace(listOfObjects: result)
                    }
                })
            } else if theTypeOfObject == "Hardware"{
                await reservationDataController.getHardwareObjects(completion: { result in
                    DispatchQueue.main.async {
                        self.setuptableHardware(listOfObjects: result)
                    }
                })
            }

        }
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
        
    
    }
    //
    
    func setuptable(listOfObjects: [SoftwareObject]){
        var counter = 0
        softwareObjects = listOfObjects
        for i in listOfObjects{
            let one = ObjectRowElement()
            if i.totalWeight == nil{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeight * 100) / 168) < 33{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeight * 100) / 168) < 66{
                one.statusLight.image = UIImage(named: "lightYellow")
            }else{
                one.statusLight.image = UIImage(named: "lightRed")
            }
            //one.frame = CGRect(x: 0, y: 0, width: 414, height: 63)
            one.isUserInteractionEnabled = true
            one.objName = i.name
            selectionList.append(i.name)
            one.heightAnchor.constraint(equalToConstant:55).isActive = true
            one.objType = typeObjectTitle.text!
            one.setupV()
            one.bookMeButton.addTarget(self, action: #selector(toNextBookingConfigView), for: .touchUpInside)
            one.bookMeButton.tag = counter
            objRowvr.addArrangedSubview(one)
            counter += 1
        }
    }
    func setuptableSpace(listOfObjects: [RoomObject]){
        var counter = 0
        RoomObjects = listOfObjects
        for i in listOfObjects{
            let one = ObjectRowElement()
            if i.totalWeight == nil{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeight * 100) / 168) < 33{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeight * 100) / 168) < 66{
                one.statusLight.image = UIImage(named: "lightYellow")
            }else{
                one.statusLight.image = UIImage(named: "lightRed")
            }
            //one.frame = CGRect(x: 0, y: 0, width: 414, height: 63)
            one.isUserInteractionEnabled = true
            one.objName = i.name
            selectionList.append(i.name)
            one.heightAnchor.constraint(equalToConstant:55).isActive = true
            one.objType = typeObjectTitle.text!
            one.setupV()
            one.bookMeButton.addTarget(self, action: #selector(toNextBookingConfigView), for: .touchUpInside)
            one.bookMeButton.tag = counter
            objRowvr.addArrangedSubview(one)
            counter += 1
        }
    }
    
    func setuptableHardware(listOfObjects: [HardwareObject]){
        var counter = 0
        hardwareObjects = listOfObjects
        for i in listOfObjects{
            let one = ObjectRowElement()
            if i.totalWeigh == nil{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeigh * 100) / 168) < 33{
                one.statusLight.image = UIImage(named: "lightGreen")
            }else if ((i.totalWeigh * 100) / 168) < 66{
                one.statusLight.image = UIImage(named: "lightYellow")
            }else{
                one.statusLight.image = UIImage(named: "lightRed")
            }
            //one.frame = CGRect(x: 0, y: 0, width: 414, height: 63)
            one.isUserInteractionEnabled = true
            one.objName = i.identifier
            selectionList.append(i.identifier)
            one.heightAnchor.constraint(equalToConstant:55).isActive = true
            one.objType = typeObjectTitle.text!
            one.setupV()
            one.bookMeButton.addTarget(self, action: #selector(toNextBookingConfigView), for: .touchUpInside)
            one.bookMeButton.tag = counter
            objRowvr.addArrangedSubview(one)
            counter += 1
        }
    }
    
    @objc func toNextBookingConfigView(sender: UIButton!) {
        vwContainer.fadeOut()
        
        // setting values to the reservation object
        self.reservation.objectTypeReservation = theTypeOfObject
        self.reservation.objectName = selectionList[sender.tag]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjectDescriptionViewController") as! ObjectDescriptionViewController
            vc.theTypeOfObject = self.theTypeOfObject
            if(self.theTypeOfObject == "Software"){
                vc.softwareObject = self.softwareObjects[sender.tag]
            } else if (self.theTypeOfObject == "Hardware"){
                vc.hardwareObject = self.hardwareObjects[sender.tag]
            } else{
                vc.roomObject = self.RoomObjects[sender.tag]
            }
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
