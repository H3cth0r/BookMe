//
//  TwoDatesConfirmationViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class TwoDatesConfirmationViewController: UIViewController {
    
    @IBOutlet weak var vwContainer: UIView!
    var reservation = ReservationClass()
    
    // Start date labels
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startNumberDayLabel: UILabel!
    @IBOutlet weak var startMonthLabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var startHourLabel: UILabel!
    
    // End date labels
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endNumberDayLabel: UILabel!
    @IBOutlet weak var endMonthLabel: UILabel!
    @IBOutlet weak var endYearLabel: UILabel!
    @IBOutlet weak var endHourLabel: UILabel!
    
    var res1: String!
    var res2: String!
    
    // check if user is editing
    var userEditing: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startHourLabel.isHidden = true
        endHourLabel.isHidden = true
        
        let dateFormatterReader = DateFormatter()
        dateFormatterReader.dateFormat = "yyyy-MM-dd"
        let startGenDate = dateFormatterReader.date(from: reservation.startDate)
        let endGenDate = dateFormatterReader.date(from: reservation.endDate)
        let dateFormatterChangeLabel = DateFormatter()
        dateFormatterChangeLabel.dateFormat = "EEEE"
        self.startDateLabel.text = dateFormatterChangeLabel.string(from: startGenDate ?? Date()).uppercased()
        self.endDateLabel.text = dateFormatterChangeLabel.string(from: endGenDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "dd"
        self.startNumberDayLabel.text = dateFormatterChangeLabel.string(from: startGenDate ?? Date()).uppercased()
        self.endNumberDayLabel.text = dateFormatterChangeLabel.string(from: endGenDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "MMMM"
        self.startMonthLabel.text = dateFormatterChangeLabel.string(from: startGenDate ?? Date()).uppercased()
        self.endMonthLabel.text = dateFormatterChangeLabel.string(from: endGenDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "yyyy"
        self.startYearLabel.text = dateFormatterChangeLabel.string(from: startGenDate ?? Date()).uppercased()
        self.endYearLabel.text = dateFormatterChangeLabel.string(from: endGenDate ?? Date()).uppercased()
        
        res1 = "\(reservation.startDate) 01:00:00.000"
        res2 = "\(reservation.endDate) 01:00:00.000"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveReservationButton(_ sender: Any) {
        
        if userEditing{
            Task{
                let reservationDataController = ReservationDataController()
                await reservationDataController.deleteTicket(tickedId: self.reservation.recivedTicket.ticketId, completion: { result in
                    print("DELETED: \(result)")
                })
            }
        }
        
        
        Task{
            var objid: Int = 0
            var objTyp: String = ""
            var objN: String = ""
            var objD: String = ""
            if reservation.theTypeOfObject == "Software"{
                objid = reservation.softwareObject.generalObjectID
                objTyp = "SFTWR"
                objN = reservation.softwareObject.name
                objD = reservation.softwareObject.description
            } else if reservation.theTypeOfObject == "Hardware"{
                objid = reservation.hardwareObject.generalObjectID
                objTyp = "HRDWR"
                objN = reservation.hardwareObject.identifier
                objD = reservation.hardwareObject.description
            } else{
                objid = reservation.roomObject.generalObjectID
                objTyp = "ROOM"
                objN = reservation.roomObject.name
                objD = reservation.roomObject.description
            }
            let reservationDataController = ReservationDataController()
            await reservationDataController.newTicket(startDate_t: res1, endDate_t: res2, objectId_t: objid, objectType_t: objTyp, objectName_t: objN, description_t: objD, completion: { result in
                print("the ticked was saved: \(result.ticketSaved)")
            })
        }
        
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
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
