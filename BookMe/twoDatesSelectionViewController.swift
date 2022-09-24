//
//  twoDatesSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class twoDatesSelectionViewController: UIViewController {
    
    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet weak var upperDateSelectionBand: UIStackView!
    @IBOutlet weak var lowerDateSelectionBand: UIStackView!
    
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    
    
    var reservation = ReservationClass()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstDateLabel.text = "DD  /  MM  /  YY"
        secondDateLabel.text = "DD  /  MM  /  YY"
        
        upperDateSelectionBand.axis = .horizontal
        upperDateSelectionBand.distribution = .fillEqually
        upperDateSelectionBand.spacing = 30
        upperDateSelectionBand.distribution = .fill
        upperDateSelectionBand.alignment = .fill
        
        
        lowerDateSelectionBand.axis = .horizontal
        lowerDateSelectionBand.distribution = .fillEqually
        lowerDateSelectionBand.spacing = 30
        lowerDateSelectionBand.distribution = .fill
        lowerDateSelectionBand.alignment = .fill
        
        var datesList: [String] = ["TUESDAY 20TH AUGUST 2022",
                                   "TUESDAY 21TH AUGUST 2022",
                                   "TUESDAY 22TH AUGUST 2022",
                                   "TUESDAY 23TH AUGUST 2022",
                                   "TUESDAY 24TH AUGUST 2022",
                                   "TUESDAY 25TH AUGUST 2022",
                                   "TUESDAY 26TH AUGUST 2022",
                                   "TUESDAY 27TH AUGUST 2022",
                                   "TUESDAY 28TH AUGUST 2022"
        ]
        
        var counter = 0
        for i in datesList{
            let one = DateCardObject()
            one.isUserInteractionEnabled = true
            one.dateText = i
            one.backgroundColor = .white
            one.heightAnchor.constraint(equalToConstant:180).isActive = true
            one.widthAnchor.constraint(equalToConstant: 280).isActive = true
            one.setupV()
            one.labelDate.text = i
            one.selectDateButton.tag = counter
            one.selectDateButton.addTarget(self, action: #selector(selectThisDate), for: .touchUpInside)
            one.labelDate.frame = CGRect(x: 10, y: 10, width: 250, height: 250)
            one.selectDateButton.frame = CGRect(x: 145, y: 260, width: 151, height: 50)
            
            upperDateSelectionBand.addArrangedSubview(one)
            //lowerDateSelectionBand.addArrangedSubview(one)
            
            counter += 1
        }
        counter = 0
        for i in datesList{
            let one = DateCardObject()
            one.isUserInteractionEnabled = true
            one.dateText = i
            one.backgroundColor = .white
            one.heightAnchor.constraint(equalToConstant:180).isActive = true
            one.widthAnchor.constraint(equalToConstant: 280).isActive = true
            one.setupV()
            one.labelDate.text = i
            one.selectDateButton.tag = counter
            one.selectDateButton.addTarget(self, action: #selector(selectThisDateSecond), for: .touchUpInside)
            one.labelDate.frame = CGRect(x: 10, y: 10, width: 250, height: 250)
            one.selectDateButton.frame = CGRect(x: 145, y: 230, width: 151, height: 50)
            
            //upperDateSelectionBand.addArrangedSubview(one)
            lowerDateSelectionBand.addArrangedSubview(one)
            
            counter += 1
        }
        
    }
    
    @objc func selectThisDate(sender: UIButton!){
        print(sender.tag)
        firstDateLabel.text = "23  /  08  /  22"
    }
    @objc func selectThisDateSecond(sender: UIButton!){
        print(sender.tag)
        secondDateLabel.text = "25  /  08  /  22"
    }
    
    @IBAction func toHourSelection(_ sender: Any) {
        vwContainer.fadeOut()
        reservation.startDate = "FROM: TUESDAY 23TH AUGUST 2022"
        reservation.endDate = "TO: TUESDAY 30TH AUGUST 2022"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourSelectionViewController") as! HourSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.reservation = self.reservation
            self.present(vc, animated: true, completion: nil)
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
