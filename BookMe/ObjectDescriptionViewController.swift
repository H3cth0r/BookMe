//
//  ObjectDescriptionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 06/09/22.
//

import UIKit

class ObjectDescriptionViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectDescriptionLabel: UILabel!
    @IBOutlet weak var maxSpaceLabelTitle: UILabel!
    @IBOutlet weak var maxSpaceLabel: UILabel!
    @IBOutlet weak var maxNumberOfDaysLabel: UILabel!
    @IBOutlet weak var maxNumberOfDaysLabelTitle: UILabel!
    
    
    var reservation = ReservationClass()
    var theTypeOfObject = ""
    var hardwareObject: HardwareObject!
    var softwareObject: SoftwareObject!
    var roomObject: RoomObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwContainer.alpha = 0.0
        vwContainer.fadeIn()
        if(self.theTypeOfObject == "Software"){
            objectNameLabel.text = softwareObject.name
            objectDescriptionLabel.text = softwareObject.description
            
            // max number of assistans
            maxSpaceLabel.isHidden = true
            maxSpaceLabelTitle.isHidden = true
            
            // max number of days
            maxNumberOfDaysLabel.text = String(softwareObject.maxDays) + " días."

            reservation.softwareObject = softwareObject
            reservation.theTypeOfObject = self.theTypeOfObject
            
        } else if (self.theTypeOfObject == "Hardware"){
            objectNameLabel.text = hardwareObject.identifier
            objectDescriptionLabel.text = hardwareObject.description
            maxSpaceLabel.isHidden = true
            maxNumberOfDaysLabel.text = String(hardwareObject.maxDays) + " días."
            
            reservation.hardwareObject = hardwareObject
            reservation.theTypeOfObject = self.theTypeOfObject
            
        } else{
            objectNameLabel.text = roomObject.name
            objectDescriptionLabel.text = roomObject.description
            maxSpaceLabel.text = String(roomObject.capacity) + " personas."
            maxNumberOfDaysLabel.text = String(roomObject.maxDays) + " días."
            
            reservation.roomObject = roomObject
            reservation.theTypeOfObject = self.theTypeOfObject
            
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func toNext(_ sender: Any) {
        vwContainer.fadeOut()
        reservation.objectTypeReservation = theTypeOfObject
        reservation.objectName = "VIM"
        if theTypeOfObject == "Space"{
            
            
            // temporal max number of assisstants variable
            // will be get from json object
            self.reservation.maxNumberOfAssistans = roomObject.capacity
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumberOfAssistantsViewController") as! NumberOfAssistantsViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                vc.reservation.theTypeOfObject = self.theTypeOfObject
                self.present(vc, animated: true, completion: nil)
            }
        }
         else{
             var numODays: Int!
             if theTypeOfObject == "Software"{
                 numODays = softwareObject.maxDays
             }else{
                 numODays = hardwareObject.maxDays
             }
             if numODays < 2{
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     //let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                     //let vc = DateSelectionViewController()
                     //vc.modalTransitionStyle = .crossDissolve
                     vc.modalPresentationStyle = .fullScreen
                     vc.reservation = self.reservation
                     vc.reservation.theTypeOfObject = self.theTypeOfObject
                     self.present(vc, animated: true, completion: nil)
                 }
             } else{
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
                     //vc.modalTransitionStyle = .crossDissolve
                     vc.modalPresentationStyle = .fullScreen
                     vc.reservation = self.reservation
                     vc.reservation.theTypeOfObject = self.theTypeOfObject
                     vc.reservation.multipleDays = true
                     self.present(vc, animated: true, completion: nil)
                 }
             }

         }
        
        
    }
    
    
    @IBAction func closeDescription(_ sender: Any) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjectSelectionViewController") as! ObjectSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.theTypeOfObject = self.theTypeOfObject
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
