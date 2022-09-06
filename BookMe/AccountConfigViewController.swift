//
//  AccountConfigViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class AccountConfigViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    @IBOutlet weak var confirmChangesView: UIView!
    
    @IBOutlet weak var mailinputspace: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmChangesView.isHidden = true
    }
    
    @IBAction func openConfirmationButton(_ sender: Any) {
        confirmChangesView.isHidden = false
    }
    @IBAction func saveDataButton(_ sender: Any) {
        confirmChangesView.isHidden = true
        if mailinputspace.text != "yledo@tec.mx" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.commingFromAccountConfig = true
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func cancelChangesButton(_ sender: Any) {
        confirmChangesView.isHidden = true
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
