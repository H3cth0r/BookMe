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
        
        // run task to run all user data
        let userDataController = userAccountDataController()
        let userDefaults = UserDefaults.standard
        let username: String = userDefaults.object(forKey: "username") as! String
        let hpass: String = userDefaults.object(forKey: "hashPassword") as! String
        Task{
            await userDataController.fetchUserAccountData(username_t:username, hashPassword_t:hpass, completion: {result in
                if(result){
                    print("Succesfull log")
                }else{
                    print("Error on log")
                }
            })
        }
        
        self.slideNavMenuController.transform  = CGAffineTransform(translationX: -self.slideNavMenuController.frame.width, y: 0.0)

        // Do any additional setup after loading the view.
        //slideNavMenuController.isHidden = true
        closeSlideNavMenuView.isHidden = true
        

        
    }
    
    @IBAction func toNewBookingButton(_ sender: UIButton) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjectTypeSelectionViewController") as! ObjectTypeSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func toCurrentBookingsButton(_ sender: Any) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentBookingsViewController") as! CurrentBookingsViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
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
        //slideNavMenuController.isHidden = false
        slideNavMenuController.layer.shadowRadius = 5
        slideNavMenuController.layer.shadowOpacity = 0.3
        UIView.animate(withDuration: 0.5, animations: {
            let zero = CGAffineTransform(translationX: 0.0, y: 0.0)
            self.slideNavMenuController.transform = zero
            //self.slideNavMenuController.frame.origin.x = -self.slideNavMenuController.frame.origin.size.width
        })
        /*
        slideNavMenuController.frame = CGRect(x: 500, y: 500, width: slideNavMenuController.frame.size.width, height: slideNavMenuController.frame.size.height)
        slideNavMenuController.layoutIfNeeded()
         */
    }
    

    
    @IBAction func closeSlideMenu(_ sender: UIButton) {
        closeSlideNavMenuView.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            let zero = CGAffineTransform(translationX: -self.slideNavMenuController.frame.width, y: 0.0)
            self.slideNavMenuController.transform = zero
            //self.slideNavMenuController.frame.origin.x = -self.slideNavMenuController.frame.origin.size.width
        })
        //slideNavMenuController.isHidden = true
    }
    
    
    @IBAction func toStatsButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
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
