//
//  SIngleDateConfirmationViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class SIngleDateConfirmationViewController: UIViewController {
    
    @IBOutlet var vwContainer: UIView!
    
    // day label
    @IBOutlet weak var dayLabel: UILabel!
    // day number label
    @IBOutlet weak var dayNumberLabel: UILabel!
    // month label
    @IBOutlet weak var monthLabel: UILabel!
    // year label
    @IBOutlet weak var yearLabel: UILabel!
    // Hour range label
    @IBOutlet weak var hourRangeLabel: UILabel!
    
    
    // check if user is editing
    var userEditing: Bool = false
    
    
    var reservation = ReservationClass()
    
    var startDateToSend: Date!
    var endDateToSend: Date!
    var res1: String!
    var res2: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dateFormatterReader = DateFormatter()
        dateFormatterReader.dateFormat = "yyyy-MM-dd"
        let genDate = dateFormatterReader.date(from: reservation.startDate)
        let dateFormatterChangeLabel = DateFormatter()
        dateFormatterChangeLabel.dateFormat = "EEEE"
        self.dayLabel.text = dateFormatterChangeLabel.string(from: genDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "dd"
        self.dayNumberLabel.text = dateFormatterChangeLabel.string(from: genDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "MMMM"
        self.monthLabel.text = dateFormatterChangeLabel.string(from: genDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "yyyy"
        self.yearLabel.text = dateFormatterChangeLabel.string(from: genDate ?? Date()).uppercased()
        dateFormatterChangeLabel.dateFormat = "HH.mm"
        let startT = dateFormatterChangeLabel.date(from: reservation.startHour)
        let endT = dateFormatterChangeLabel.date(from: reservation.endHour)
        dateFormatterChangeLabel.dateFormat = "HH"
        let sh = dateFormatterChangeLabel.string(from: startT ?? Date())
        let eh = dateFormatterChangeLabel.string(from: endT ?? Date())
        dateFormatterChangeLabel.dateFormat = "mm"
        let sm = dateFormatterChangeLabel.string(from: startT ?? Date())
        let em = dateFormatterChangeLabel.string(from: endT ?? Date())
        hourRangeLabel.text = reservation.startHour + reservation.endHour
        res1 = "\(reservation.startDate) \(sh):\(sm):00.000"
        res2 = "\(reservation.endDate) \(eh):\(em):00.000"
        print(res1 ?? "")
        print(res2 ?? "")
        
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
