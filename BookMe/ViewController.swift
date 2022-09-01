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
    

}

