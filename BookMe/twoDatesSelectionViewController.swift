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
    
    var dateList: [String]!
    var UdtCardObj: [UIView] = []
    var LdtCardObj: [UIView] = []
    var listdais: [String] = []
    
    // check if user is editing
    var userEditing: Bool = false
    var ticketStartDate: Date!
    var ticketEndDate: Date!
    
    // list of all the cards in bands
    var listOfAllDays: [String] = []
    var listOFAllDaysDate: [Date] = []
    
    var selectedDateOne = false
    var selectedDateOneIndex: Int?
    var selectedDateOneDate: Date!
    var selectedDateTwo = false
    var selectedDateTwoIndex: Int?
    var selectedDateTwoDate: Date!
    
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
        
        Task{
            let reservationDataController = ReservationDataController()
            var objid = 0
            if reservation.theTypeOfObject == "Software"{
                objid = Int(reservation.softwareObject.generalObjectID)
            }else if reservation.theTypeOfObject == "Hardware"{
                objid = Int(reservation.hardwareObject.generalObjectID)
            }else{
                objid = Int(reservation.roomObject.generalObjectID)
            }
            await reservationDataController.getTimeRangesForDays(objectId: objid,completion: { result in
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                
                var sd = Date()
                var ed = Date()
                for i in result{
                    sd = dateFormatterGet.date(from: i.startDay) ?? Date()
                    ed = dateFormatterGet.date(from: i.endDay) ?? Date()
                    while sd <= ed{
                        self.listdais.append(dateFormatterGet.string(from: sd))
                        print("STARTDATE \(i.startDay)  ENDATE\(i.endDay)")
                        sd = Calendar.current.date(byAdding: .day, value: 1, to: sd) ?? Date()
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                    var counter: Int = 0
                    var startDate = Date()
                    let dateFormatterPrint = DateFormatter()
                    let dateFormatterRead = DateFormatter()
                    let dateFormatterResult = DateFormatter()
                    dateFormatterResult.dateFormat = "dd / MM / yy"
                    dateFormatterPrint.dateFormat = "EEEE dd MMMM yyyy"
                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                    dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                    if self.userEditing{
                        self.ticketStartDate = dateFormatterRead.date(from: self.reservation.recivedTicket.startDate) ?? Date()
                        self.ticketEndDate = dateFormatterRead.date(from: self.reservation.recivedTicket.endDate) ?? Date()
                        
                        self.selectedDateOne = true
                        self.selectedDateTwo = true
                        
                        self.firstDateLabel.text = dateFormatterResult.string(from: self.ticketStartDate)
                        self.secondDateLabel.text = dateFormatterResult.string(from: self.ticketEndDate)
                        
                    }
                    for _ in 0...29{
                        let one = DateCardObject()
                        one.isUserInteractionEnabled = true
                        one.dateText = dateFormatterPrint.string(from: startDate).uppercased()
                        one.heightAnchor.constraint(equalToConstant:180).isActive = true
                        one.widthAnchor.constraint(equalToConstant: 280).isActive = true
                        one.setupV()
                        one.labelDate.text = dateFormatterPrint.string(from: startDate).uppercased()
                        self.listOfAllDays.append(dateFormatterGet.string(from: startDate))
                        self.listOFAllDaysDate.append(startDate)
                        one.selectDateButton.addTarget(self, action: #selector(self.selectThisDateSecond), for: .touchUpInside)
                        one.selectDateButton.tag = counter
                        one.labelDate.frame = CGRect(x: 10, y: -15, width: 250, height: 250)
                        one.selectDateButton.frame = CGRect(x: 145, y: 220, width: 151, height: 50)
                        if self.listdais.contains(dateFormatterGet.string(from: startDate)){
                            one.backgroundColor = .gray
                            one.selectDateButton.isHidden = true
                            one.isOccupied = true
                        }else{
                            one.backgroundColor = .white
                        }
                        if self.userEditing{
                            if (startDate >= self.ticketStartDate && startDate <= self.ticketEndDate){
                                one.backgroundColor = .white
                                one.selectDateButton.isHidden = false
                                one.isOccupied = false
                                
                                if self.isSameDay(date1: startDate, date2: self.ticketStartDate){
                                    self.selectedDateOneIndex = one.tag
                                }
                                if self.isSameDay(date1: startDate, date2: self.ticketEndDate){
                                    self.selectedDateTwoIndex = one.tag
                                }
                                
                            }
                        }
                        self.LdtCardObj.append(one)
                        
                        let two = DateCardObject()
                        two.isUserInteractionEnabled = true
                        two.dateText = dateFormatterPrint.string(from: startDate).uppercased()
                        two.backgroundColor = .white
                        two.heightAnchor.constraint(equalToConstant:180).isActive = true
                        two.widthAnchor.constraint(equalToConstant: 280).isActive = true
                        two.setupV()
                        two.labelDate.text = dateFormatterPrint.string(from: startDate).uppercased()
                        two.selectDateButton.addTarget(self, action: #selector(self.selectThisDate), for: .touchUpInside)
                        two.selectDateButton.tag = counter
                        two.labelDate.frame = CGRect(x: 10, y: -15, width: 250, height: 250)
                        two.selectDateButton.frame = CGRect(x: 145, y: 220, width: 151, height: 50)
                        if self.listdais.contains(dateFormatterGet.string(from: startDate)){
                            two.backgroundColor = .gray
                            two.selectDateButton.isHidden = true
                            two.isOccupied = true
                        }else{
                            two.backgroundColor = .white
                        }
                        if self.userEditing{
                            if (startDate >= self.ticketStartDate && startDate <= self.ticketEndDate){
                                two.backgroundColor = .white
                                two.selectDateButton.isHidden = false
                                two.isOccupied = false
                                
                                if self.isSameDay(date1: startDate, date2: self.ticketStartDate){
                                    self.selectedDateOneIndex = two.tag
                                }
                                if self.isSameDay(date1: startDate, date2: self.ticketEndDate){
                                    self.selectedDateTwoIndex = two.tag
                                }
                                
                            }
                        }
                        self.UdtCardObj.append(two)
                        
                        counter += 1
                        startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? Date()
                    }

                    
                    self.setElementsToView()
                }
            })
        }
        
        
    }
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    @objc func selectThisDate(sender: UIButton!){
        
        if selectedDateTwo{
            selectedDateTwo = false
            selectedDateTwoDate = nil
            secondDateLabel.text = "DD  /  MM  /  YY"
        }
        secondDateLabel.textColor = .white
        
        selectedDateOne = true
        selectedDateOneIndex = sender.tag
        selectedDateOneDate = listOFAllDaysDate[sender.tag]
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd / MM / yy"
        firstDateLabel.text = dateFormatterPrint.string(from: selectedDateOneDate)
        
    }
    @objc func selectThisDateSecond(sender: UIButton!){
        secondDateLabel.text = "25  /  08  /  22"
        
        if !selectedDateOne || (selectedDateOneIndex ?? 0 > sender.tag){
            selectedDateTwo = false
            selectedDateTwoIndex = nil
            selectedDateTwoDate = nil
            secondDateLabel.text = "DD  /  MM  /  YY"
            secondDateLabel.textColor = .red
            return
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        //var sd = Date()
        //var ed = Calendar.current.date(byAdding: .day, value: 30, to: sd) ?? Date()
        var maxNDays = 1
        if reservation.objectTypeReservation == "Software"{
           maxNDays = reservation.softwareObject.maxDays
        } else if reservation.objectTypeReservation == "Hardware"{
            maxNDays = reservation.hardwareObject.maxDays
        } else {
            maxNDays = reservation.roomObject.maxDays
        }
        
        if sender.tag - (selectedDateOneIndex ?? 0) > maxNDays{
            selectedDateTwo = false
            selectedDateTwoIndex = nil
            selectedDateTwoDate = nil
            secondDateLabel.text = "DD  /  MM  /  YY"
            secondDateLabel.textColor = .red
            return
        }
        
        for i in (selectedDateOneIndex ?? 0)...sender.tag{
            if listdais.contains(listOfAllDays[i]){
                selectedDateTwo = false
                selectedDateTwoDate = nil
                secondDateLabel.text = "DD  /  MM  /  YY"
                secondDateLabel.textColor = .red
                return
            }
        }
        
        secondDateLabel.textColor = .white
        
        selectedDateTwo = true
        selectedDateTwoIndex = sender.tag
        selectedDateTwoDate = listOFAllDaysDate[sender.tag]
        
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd / MM / yy"
        secondDateLabel.text = dateFormatterPrint.string(from: selectedDateTwoDate)
        
        
    }
    
    @IBAction func toHourSelection(_ sender: Any) {
        if(!selectedDateOne && !selectedDateTwo){
            return
        }
        vwContainer.fadeOut()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        reservation.startDate = dateFormatterGet.string(from: selectedDateOneDate)
        reservation.endDate = dateFormatterGet.string(from: selectedDateTwoDate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TwoDatesConfirmationViewController") as! TwoDatesConfirmationViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.userEditing = self.userEditing
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
    
    func setElementsToView(){
        for (i, j) in zip(UdtCardObj, LdtCardObj){
            self.upperDateSelectionBand.addArrangedSubview(i)
            self.lowerDateSelectionBand.addArrangedSubview(j)
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
