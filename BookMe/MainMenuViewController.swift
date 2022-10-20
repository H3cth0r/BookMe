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
    @IBOutlet weak var nextReservationStartLabel: UILabel!
    @IBOutlet weak var nextReservationEndLabel: UILabel!
    
    @IBOutlet weak var nextReservationOutlet: UIButton!
    
    var nextReservation: Ticket!
    
    var closestReservationDate: TicketInList!
    
    @IBOutlet weak var mainProfilePictureImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // run task to run all user data
        
        // Task for getting the current tickets
        Task{
            let reservationDataController = ReservationDataController()
            await reservationDataController.getTickets(completion: { result in
                let dateFormatterRead = DateFormatter()
                dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                var closestDate = TicketInList(endDate: "none", objectName: "none", objectType: "none", startDate: "none", ticketId: 0)
                if result.count > 0{
                    closestDate = result[0]
                }
                else{
                    DispatchQueue.main.async {
                        self.nextReservationOutlet.backgroundColor = .white
                        self.nextReservationOutlet.isUserInteractionEnabled = false
                    }
                    return
                }
                for i in result{
                    if dateFormatterRead.date(from: String(i.startDate)) ?? Date() < dateFormatterRead.date(from: String(closestDate.startDate)) ?? Date(){
                        closestDate = i
                    }
                }
                self.closestReservationDate = closestDate
                
                DispatchQueue.main.async {
                    dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.locale = Locale(identifier: "en-US")
                    dateFormatterPrint.dateFormat = "MMMM dd'TH' HH:mm"
                    
                    let sdat = dateFormatterRead.date(from: String(self.closestReservationDate.startDate))
                    let edat = dateFormatterRead.date(from: String(self.closestReservationDate.endDate))
                    
                    self.nextReservationStartLabel.text = dateFormatterPrint.string(from: sdat ?? Date())
                    self.nextReservationEndLabel.text = dateFormatterPrint.string(from: edat ?? Date())
                }
                

            })
        }
        
        Task{
            let defaults = UserDefaults.standard
            
            let loggedWithEmail         = defaults.object(forKey: "loggedWithEmail") as! Bool
            let username_t: String!
            if !loggedWithEmail{
                username_t             = defaults.object(forKey: "username") as? String
            }else{
                username_t            = defaults.object(forKey: "userEmail") as? String
            }
            
            let hashpwd_t = defaults.object(forKey: "userHashPassword") as! String
            let userDataController = userAccountDataController()
            await userDataController.fetchUserAccountData(username_t: username_t, hashPassword_t: hashpwd_t, completion: { result in
                
                DispatchQueue.main.async {
                    // profile picture
                    let pfp = defaults.object(forKey: "pfp") as? String
                    let dataDecoded : Data = Data(base64Encoded: pfp!, options: .ignoreUnknownCharacters)!
                    let decodedimage = UIImage(data: dataDecoded)
                    self.mainProfilePictureImage.contentMode = .scaleAspectFill
                    self.mainProfilePictureImage.clipsToBounds = true
                    self.mainProfilePictureImage.image = decodedimage
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
            vc.theTicketId = self.closestReservationDate.ticketId
            vc.theObjectType = self.closestReservationDate.objectType
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
