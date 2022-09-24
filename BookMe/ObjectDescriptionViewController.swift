//
//  ObjectDescriptionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 06/09/22.
//

import UIKit

class ObjectDescriptionViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    var reservation = ReservationClass()
    var theTypeOfObject = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwContainer.alpha = 0.0
        vwContainer.fadeIn()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func toNext(_ sender: Any) {
        vwContainer.fadeOut()
        reservation.objectTypeReservation = theTypeOfObject
        reservation.objectName = "VIM"
        if theTypeOfObject == "Space"{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumberOfAssistantsViewController") as! NumberOfAssistantsViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                self.present(vc, animated: true, completion: nil)
            }
        } else{
            let boolRandom = Bool.random()
            if boolRandom{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                    //let vc = DateSelectionViewController()
                    //vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    //vc.reservation = self.reservation
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
    }
    
    
    @IBAction func closeDescription(_ sender: Any) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjectSelectionViewController") as! ObjectSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.theTypeOfObject = self.theTypeOfObject
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
