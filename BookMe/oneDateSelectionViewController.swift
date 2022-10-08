//
//  oneDateSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class oneDateSelectionViewController: UIViewController {
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var objCard: UIStackView!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    
    var reservation = ReservationClass()
    
    // check if user is editing
    var userEditing: Bool = false
    
    var listOfDates: [Date]!
    
    var selected: Bool = false
    
    var theSelectedDate: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        // https://www.youtube.com/watch?v=6Qd3CdWYeJ8
        objCard.axis = .horizontal
        objCard.distribution = .fillEqually
        objCard.spacing = 30
        objCard.distribution = .fill
        objCard.alignment = .fill
        
        selectedDateLabel.text = "DD  /  MM  /  YY"
        selectedDateLabel.textColor = .white

        var counter: Int = 0
        var startDate = Date()
        let dateFormatterCard = DateFormatter()
        dateFormatterCard.dateFormat = "EEEE dd MMMM yyyy"
        listOfDates = []
        
        for _ in 0...29{
            let one = DateCardObject()
            one.isUserInteractionEnabled = true
            one.dateText = dateFormatterCard.string(from: startDate).uppercased()
            one.backgroundColor = .white
            one.heightAnchor.constraint(equalToConstant:380).isActive = true
            one.widthAnchor.constraint(equalToConstant: 280).isActive = true
            one.setupV()
            one.labelDate.text = dateFormatterCard.string(from: startDate).uppercased()
            one.selectDateButton.tag = counter
            one.selectDateButton.addTarget(self, action: #selector(selectThisDate), for: .touchUpInside)
            one.labelDate.frame = CGRect(x: 10, y: -25, width: 250, height: 250)
            one.selectDateButton.frame = CGRect(x: 145, y: 320, width: 151, height: 50)
            objCard.addArrangedSubview(one)
            counter += 1
            
            listOfDates.append(startDate)
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? Date()
        }

    }
    
    @objc func selectThisDate(sender: UIButton!){
        print(sender.tag)
        let dateFormatterSelection = DateFormatter()
        dateFormatterSelection.dateFormat = "dd / MM / yy"
        let dateFormatterSelectionFormat = DateFormatter()
        dateFormatterSelectionFormat.dateFormat = "yyyy-MM-dd"
        let res = dateFormatterSelection.date(from: selectedDateLabel.text ?? "")
        theSelectedDate = dateFormatterSelectionFormat.string(from: res ?? Date())
        selected = true
        selectedDateLabel.text = dateFormatterSelection.string(from: self.listOfDates[sender.tag])
    }
    
    @IBAction func toHourSelection(_ sender: Any) {
        if !selected{
            return
        }
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourSelectionViewController") as! HourSelectionViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.reservation = self.reservation
            vc.reservation.startDate = self.theSelectedDate!
            vc.reservation.endDate = self.theSelectedDate!
            vc.reservation = self.reservation
            vc.userEditing = self.userEditing       // <-----------
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
