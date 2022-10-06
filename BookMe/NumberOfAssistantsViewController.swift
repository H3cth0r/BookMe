//
//  NumberOfAssistantsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/09/22.
//

import UIKit

class NumberOfAssistantsViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var selectedNumberOfAssistants: UILabel!
    var currentNumOfAssistants = 1
    
    var reservation = ReservationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectedNumberOfAssistants.text = String(currentNumOfAssistants)
        
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
    }
    
    @IBAction func toDateSelection(_ sender: Any) {
        
        reservation.numberOfAssistants = currentNumOfAssistants
        
        vwContainer.fadeOut()
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
    
    
    @IBAction func addAssistantsButton(_ sender: Any) {
        if(reservation.maxNumberOfAssistans-1 >= currentNumOfAssistants){
            currentNumOfAssistants += 1
            selectedNumberOfAssistants.text = String(currentNumOfAssistants)
        }
    }
    
    @IBAction func decreaseAssistantsButton(_ sender: Any) {
        if(currentNumOfAssistants >= 2){
            currentNumOfAssistants -= 1
            selectedNumberOfAssistants.text = String(currentNumOfAssistants)
        }
    }
    @IBAction func toMainMenuButton(_ sender: Any) {
        // To Main Menu after some time
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
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
