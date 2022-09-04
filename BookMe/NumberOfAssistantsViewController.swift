//
//  NumberOfAssistantsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit

class NumberOfAssistantsViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    var reservation = ReservationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
    }
    
    @IBAction func toDateSelection(_ sender: Any) {
        vwContainer.fadeOut()
        
        reservation.numberOfAssistants = 3
        
        let boolRandom = Bool.random()
        if boolRandom{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                self.present(vc, animated: true, completion: nil)
            }
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
