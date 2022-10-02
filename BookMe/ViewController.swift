//
//  ViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 28/08/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var vwContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //let defaults = UserDefaults
       // UserDefaults.resetStandardUserDefaults()
        
        //print(defaults.bool(forKey: "doneBasicTutorial"))
        if UserDefaults.standard.bool(forKey: "doneBasicTutorial") {
            toInfoOrReserv()
        }
        
    }
    
    @IBAction func buttonNextView(_ sender: UIButton) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeInfoTwoVController") as! WelcomeInfoTwoVController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }

        //vwContainer.fadeIn()
    }
    
    func toInfoOrReserv(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReserveOrMoreInfoViewController") as! ReserveOrMoreInfoViewController
        //vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    

}

