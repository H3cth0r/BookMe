//
//  CurrentBookingsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class CurrentBookingsViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet weak var deleteBookingMenu: UIView!
    
    
    @IBOutlet weak var objRowvr: UIStackView!
    
    var rowToHide: Int!
    
    var rowsReservationItems: [ReservationRowObjectView]! = []
    var resultListObjects: [TicketInList]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        deleteBookingMenu.isHidden = true
        
        objRowvr.axis = .vertical
        objRowvr.distribution = .fillEqually
        objRowvr.spacing = 5
        objRowvr.distribution = .fill
        objRowvr.alignment = .fill
        /*
        var softwareTitleName: [String] = ["Software: Adobe XD",
                                           "Software: Autocad",
                                           "Software: Blender",
                                           "Software: VIM",
                                           "Software: Inkscape",
                                           "Software: Figma",
                                           "Software: Terminal",
                                           "Software: Ubuntu",
                                           "Software: Word",
                                           "Software: AutoDesk",
                                           "Software: Powerpoint",
                                           "Software: Excel",
                                        "Software: Android"]
        */
        
        Task{
            let reservationDataController = ReservationDataController()
            await reservationDataController.getTickets(completion: { result in
                print(result)
                self.resultListObjects = result
                DispatchQueue.main.async {
                    let dateFormatterRead = DateFormatter()
                    dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd HH:mm"
                    var sd = Date()
                    var ed = Date()
                    var counter = 0
                    for i in self.resultListObjects{
                        let one = ReservationRowObjectView()
                        one.isUserInteractionEnabled = true
                        one.objName = i.objectName
                        one.heightAnchor.constraint(equalToConstant:70).isActive = true
                        //one.backgroundColor = .red
                        one.qrCodeButton.tag = counter
                        one.qrCodeButton.addTarget(self, action: #selector(self.openTicketButton), for: .touchUpInside)
                        one.deleteButton.tag = counter
                        one.deleteButton.addTarget(self, action: #selector(self.deleteTicketButton), for: .touchUpInside)
                        one.setupV()
                        
                        sd = dateFormatterRead.date(from: i.startDate) ?? Date()
                        ed = dateFormatterRead.date(from: i.endDate) ?? Date()
                        one.initialDateLabel.text = dateFormatterPrint.string(from: sd).uppercased()
                        one.endDateLabel.text = dateFormatterPrint.string(from: ed).uppercased()

                        self.rowsReservationItems.append(one)
                        //objRowvr.addArrangedSubview(one)
                        self.objRowvr.addArrangedSubview(self.rowsReservationItems[counter])
                        counter += 1
                    }
                }
            })
        }
        
    }
    
    
    @objc func openTicketButton(sender: UIButton!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
            //vc.modalTransitionStyle = .crossDissolve
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func deleteTicketButton(sender: UIButton!) {
        deleteBookingMenu.isHidden = false
        rowToHide = sender.tag
        //let view = self.objRowvr.subviews[sender.tag]
        //view.isHidden = true
        //view.removeFromSuperview()
        //print(sender.tag)
    }
    
    
    @IBAction func confirmDeleteReservation(_ sender: Any) {
        deleteBookingMenu.isHidden = true
        let view = self.objRowvr.subviews[rowToHide]
        view.isHidden = true
        //view.removeFromSuperview()
        //print(sender.tag)
    }
    
    
    @IBAction func cancelDeleteReservation(_ sender: Any) {
        deleteBookingMenu.isHidden = true
    }
    
    
    @IBAction func closeCurrentBookings(_ sender: Any) {
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
