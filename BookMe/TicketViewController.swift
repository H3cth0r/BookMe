//
//  TicketViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    var reservation = ReservationClass()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.reservation = self.reservation
            self.present(vc, animated: true, completion: nil)
        }
         */
        //weak var currentVC = self.presentationController
        var presentingViewController: UIViewController! = self.presentingViewController
        self.dismiss(animated: false) {
              // go back to MainMenuView as the eyes of the user
            //presentingViewController.dismiss(animated: false, completion: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.reservation = self.reservation
            presentingViewController.present(vc, animated: true, completion: nil)
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
