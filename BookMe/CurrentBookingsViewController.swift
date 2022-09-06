//
//  CurrentBookingsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class CurrentBookingsViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet weak var deleteBookingMenu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        deleteBookingMenu.isHidden = true
    }
    
    
    @IBAction func openTicketButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteTicketButton(_ sender: Any) {
        deleteBookingMenu.isHidden = false
    }
    
    
    @IBAction func confirmDeleteReservation(_ sender: Any) {
        deleteBookingMenu.isHidden = true
    }
    
    
    @IBAction func cancelDeleteReservation(_ sender: Any) {
        deleteBookingMenu.isHidden = true
    }
    
    
    @IBAction func closeCurrentBookings(_ sender: Any) {
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
