//
//  SlideMenuViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit

class SlideMenuViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toAccountConfigView(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountConfigViewController") as! AccountConfigViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func toCreditsViewButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreditsViewController") as! CreditsViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func toTicketsButton(_ sender: Any) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentBookingsViewController") as! CurrentBookingsViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func toStatsViewButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func toMoreInfoOfTheHub(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoreInfoOfHubViewController") as! MoreInfoOfHubViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func LogOutButton(_ sender: Any) {
        
        let userDafaults = UserDefaults.standard
        userDafaults.set(0,         forKey: "userIsBlocked")
        userDafaults.set("",        forKey: "userFirstName")
        userDafaults.set("",        forKey: "userEmail")
        userDafaults.set("none",    forKey: "userJWT")
        userDafaults.set("",        forKey: "username")
        userDafaults.set("",        forKey: "userLastName")
        userDafaults.set("",        forKey: "userHashPassword")
        userDafaults.set("",        forKey: "userIsAdmin")
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReserveOrMoreInfoViewController") as! ReserveOrMoreInfoViewController
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
