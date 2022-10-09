//
//  HourSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 04/09/22.
//

import UIKit

class HourSelectionViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var hourViewPicker: UIPickerView!
    @IBOutlet weak var currentHourLabel: UILabel!
    @IBOutlet weak var startingButtonOutlet: UIButton!
    @IBOutlet weak var endingButtonOutlet: UIButton!
    
    // check if user is editing
    var userEditing: Bool = false
    
    var currentRowIndex: Int = 1
    var startInRowIndex: Int = 1
    
    var startHourRowNumber: Int!
    var endHourRowNumber: Int!
    
    var selecting = false
    var endSelected = false
    
    var hourModelPicker: HourModelPicker!
    
    var occuDatesList: [Date] = []
    
    var reservation = ReservationClass()
    var modelData: [HourModel] = []

    var modelDataBackup: [HourModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            let reservationDataController = ReservationDataController()
            let theObjId: Int!
            if self.reservation.theTypeOfObject == "Software"{
                theObjId = self.reservation.softwareObject.generalObjectID
            }else if self.reservation.theTypeOfObject == "Hardware"{
                theObjId = self.reservation.hardwareObject.generalObjectID
            }else{
                theObjId = self.reservation.roomObject.generalObjectID
            }
            print("THE DATE \(self.reservation.startDate)")
            await reservationDataController.getTimeRanges(theDate: self.reservation.startDate, objID: theObjId,completion: { result in
                let dateFormatterGetHour = DateFormatter()
                dateFormatterGetHour.dateFormat = "HH"
                let dateFormatterGetMin = DateFormatter()
                dateFormatterGetMin.dateFormat = "mm"
                let dateFormatterReader = DateFormatter()
                dateFormatterReader.dateFormat = "HH:mm:ss"
                var startDate = dateFormatterReader.date(from: "07:00:00")
                
                let normalFormatDate = DateFormatter()
                normalFormatDate.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                
                var occu = false
                var selected = false
                
                var sdat = Date()
                var edat = Date()
                
                var stringDateHandler = ""
                
                print("RECIVED TICKET")
                print(self.reservation.recivedTicket)
                
                for _ in 0...144{
                    for j in result{
                        sdat = dateFormatterReader.date(from: j.startTime) ?? Date()
                        edat = dateFormatterReader.date(from: j.endTime) ?? Date()
                        if(startDate ?? Date() >= sdat && startDate ?? Date() <= edat){
                            occu = true
                        }
                        

                        
                        if(self.userEditing && startDate ?? Date() >= sdat && startDate ?? Date() <= edat){
                            sdat = normalFormatDate.date(from: self.reservation.recivedTicket.startDate) ?? Date()
                            stringDateHandler = dateFormatterReader.string(from: sdat)
                            sdat = dateFormatterReader.date(from: stringDateHandler) ?? Date()
                            
                            edat = normalFormatDate.date(from: self.reservation.recivedTicket.endDate) ?? Date()
                            stringDateHandler = dateFormatterReader.string(from: edat)
                            edat = dateFormatterReader.date(from: stringDateHandler) ?? Date()
                            print("YESSSSSSSSSS")
                            occu = false
                            selected = true
                            self.selecting = true
                        }
                    }
                    let hourModel = HourModel(hour: Int(dateFormatterGetHour.string(from: startDate!))!, minute: Int(dateFormatterGetMin.string(from: startDate!))!, occupied: occu, occupy: selected)
                    occu = false
                    selected = false
                    self.modelData.append(hourModel)
                    startDate = Calendar.current.date(byAdding: .minute, value: 5, to: startDate!) ?? Date()
                }
                
                DispatchQueue.main.async{
                    self.hourViewPicker.delegate = self
                    self.hourViewPicker.dataSource = self
                    self.hourViewPicker.selectRow(self.currentRowIndex, inComponent: 0, animated: true)
                }
                
            })
        }
    
        startingButtonOutlet.setTitleColor(.white, for: .normal)
        
        print(modelData.count)
        
        // modelData backup
        modelDataBackup = modelData
        
        // https://www.youtube.com/watch?v=6Qd3CdWYeJ8
        // https://www.youtube.com/watch?v=lICHh10y_XU
        //hourViewPicker.delegate = hourModelPicker
        //hourViewPicker.dataSource = hourModelPicker
        hourViewPicker.delegate = self
        hourViewPicker.dataSource = self
        hourViewPicker.selectRow(startInRowIndex, inComponent: 0, animated: true)
        //hourViewPicker.delegate = ??
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setStartingHour(_ sender: UIButton) {
        
        print(startInRowIndex)
        
        endSelected = false
        // Check if occupied
        if modelData[currentRowIndex].occupied{
            // color the text of the button to be orange
            startingButtonOutlet.setTitle("Start", for: .normal)
            startingButtonOutlet.setTitleColor(.orange, for: .normal)
            //print("no")
            // dont do nothing else
        } else if selecting == false{
            
            startingButtonOutlet.setTitle(currentHourLabel.text, for: .normal)
            startInRowIndex = currentRowIndex
            // default set white color of the Button
            startingButtonOutlet.setTitleColor(.white, for: .normal)
            
            
            selecting = true
            startHourRowNumber = currentRowIndex
            endHourRowNumber = currentRowIndex
            modelData[currentRowIndex].occupy = true
            hourViewPicker.delegate = self
            hourViewPicker.dataSource = self
            hourViewPicker.selectRow(currentRowIndex, inComponent: 0, animated: true)
        }  else {
            
            startingButtonOutlet.setTitle(currentHourLabel.text, for: .normal)
            startInRowIndex = currentRowIndex
            // default set white color of the Button
            startingButtonOutlet.setTitleColor(.white, for: .normal)
            
            
            selecting = true
            for i in modelData{
                i.occupy = false
            }
            startHourRowNumber = currentRowIndex
            endHourRowNumber = currentRowIndex
            modelData[currentRowIndex].occupy = true
            hourViewPicker.delegate = self
            hourViewPicker.dataSource = self
            hourViewPicker.selectRow(currentRowIndex, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func setEndingHour(_ sender: UIButton) {
        
        if endSelected && currentRowIndex < endHourRowNumber{
            for i in 0...modelData.count-1{
                modelData[i].occupy = false
            }
        }
        
        startInRowIndex = currentRowIndex
        endHourRowNumber = currentRowIndex
        //print(startInRowIndex)
        
        if startHourRowNumber == nil{
            endingButtonOutlet.setTitle("End", for: .normal)
            endingButtonOutlet.setTitleColor(.orange, for: .normal)
        }else if startHourRowNumber >= endHourRowNumber || modelData[currentRowIndex].occupied{
            endingButtonOutlet.setTitle("End", for: .normal)
            endingButtonOutlet.setTitleColor(.orange, for: .normal)
        }else if selecting == true{
            
            for i in startHourRowNumber...endHourRowNumber{
                if modelData[i].occupied{
                    endingButtonOutlet.setTitle("End", for: .normal)
                    endingButtonOutlet.setTitleColor(.orange, for: .normal)
                    return
                }
            }
            
            endSelected = true
            
            endingButtonOutlet.setTitle(currentHourLabel.text, for: .normal)
            endingButtonOutlet.setTitleColor(.white, for: .normal)
            
            
            for i in startHourRowNumber...endHourRowNumber{
                modelData[i].occupy = true
            }
            hourViewPicker.delegate = self
            hourViewPicker.dataSource = self
            hourViewPicker.selectRow(currentRowIndex, inComponent: 0, animated: true)
            
        }
    }
    
    @IBAction func toConfirmation(_ sender: Any) {
        vwContainer.fadeOut()
        reservation.startHour = startingButtonOutlet.titleLabel?.text ?? "00.00"
        reservation.endHour = endingButtonOutlet.titleLabel?.text ?? "00.00"
        if !reservation.multipleDays{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIngleDateConfirmationViewController") as! SIngleDateConfirmationViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                vc.userEditing = self.userEditing
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TwoDatesConfirmationViewController") as! TwoDatesConfirmationViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                //vc.userEditing = self.userEditing
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func toMainMenu(_ sender: Any) {
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

extension HourSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = HourPickerRowView()
        view.frame = CGRect(x: 0, y: 0, width: 217, height: 50)
        modelData[row].hourToString()
        view.hourLabel.text = modelData[row].stringHour
        view.heightAnchor.constraint(equalToConstant:50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 217).isActive = true
        view.setupV()
        //view.occupyRow.isHidden = modelData[row].occupy
        if(modelData[row].occupy == false){
            view.occupyRow.isHidden = true
        } else if(modelData[row].occupy == true){
            view.occupyRow.isHidden = false
        }
        
        if(modelData[row].occupied == false){
            view.occupiedRow.isHidden = true
        } else if(modelData[row].occupied == true){
            view.occupiedRow.isHidden = false
        }
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentHourLabel.text = modelData[row].stringHour
        currentRowIndex = row
    }
    
    
    
}
