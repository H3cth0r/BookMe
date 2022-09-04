//
//  twoDatesSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class twoDatesSelectionViewController: UIViewController {
    
    @IBOutlet weak var vwContainer: UIView!
    var reservation = ReservationClass()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toHourSelection(_ sender: Any) {
        vwContainer.fadeOut()
        reservation.startDate = "FROM: TUESDAY 23TH AUGUST 2022"
        reservation.endDate = "TO: TUESDAY 30TH AUGUST 2022"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourSelectionViewController") as! HourSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.reservation = self.reservation
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
