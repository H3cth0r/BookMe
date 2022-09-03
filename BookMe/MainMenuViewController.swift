//
//  MainMenuViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit
import SwiftUI

class MainMenuViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    @IBOutlet weak var slideNavMenuController: UIView!
    
    
    @IBOutlet weak var closeSlideNavMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slideNavMenuController.isHidden = true
        closeSlideNavMenuView.isHidden = true

        
    }
    
    
    @IBAction func toCommingTicket(_ sender: UIButton) {
        //vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func showSlideMenu(_ sender: UIButton) {
        closeSlideNavMenuView.isHidden = false
        slideNavMenuController.isHidden = false
        slideNavMenuController.layer.shadowRadius = 5
        slideNavMenuController.layer.shadowOpacity = 0.3
        /*
        slideNavMenuController.frame = CGRect(x: 500, y: 500, width: slideNavMenuController.frame.size.width, height: slideNavMenuController.frame.size.height)
        slideNavMenuController.layoutIfNeeded()
         */
    }
    

    
    @IBAction func closeSlideMenu(_ sender: UIButton) {
        closeSlideNavMenuView.isHidden = true
        slideNavMenuController.isHidden = true
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
