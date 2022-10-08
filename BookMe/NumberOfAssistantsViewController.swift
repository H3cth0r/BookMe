//
//  NumberOfAssistantsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit

class NumberOfAssistantsViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var selectedNumberOfAssistants: UILabel!
    var currentNumOfAssistants = 1
    
    // check if user is editing
    var userEditing: Bool = false
    var recivedTicket: Ticket!
    
    var reservation = ReservationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectedNumberOfAssistants.text = String(currentNumOfAssistants)
        
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
    }
    
    @IBAction func toDateSelection(_ sender: Any) {
        
        reservation.numberOfAssistants = currentNumOfAssistants
        
        vwContainer.fadeOut()
        
        let dateFormatterRead = DateFormatter()
        dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let sd = dateFormatterRead.date(from: String(recivedTicket.startDate)) ?? Date()
        let ed = dateFormatterRead.date(from: String(recivedTicket.endDate)) ?? Date()
        
        if reservation.roomObject.maxDays <= 1{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                vc.reservation = self.reservation
                vc.userEditing = true           // <---------------
                vc.reservation.recivedTicket = self.recivedTicket
                vc.reservation.objectTypeReservation = "Space"
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                vc.reservation = self.reservation
                vc.userEditing = true           // <---------------
                vc.reservation.recivedTicket = self.recivedTicket
                vc.reservation.objectTypeReservation = "Space"
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    @IBAction func addAssistantsButton(_ sender: Any) {
        if(reservation.maxNumberOfAssistans-1 >= currentNumOfAssistants){
            currentNumOfAssistants += 1
            selectedNumberOfAssistants.text = String(currentNumOfAssistants)
        }
    }
    
    @IBAction func decreaseAssistantsButton(_ sender: Any) {
        if(currentNumOfAssistants >= 2){
            currentNumOfAssistants -= 1
            selectedNumberOfAssistants.text = String(currentNumOfAssistants)
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
