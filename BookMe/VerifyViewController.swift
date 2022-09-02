//
//  VerifyViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit

class VerifyViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
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
