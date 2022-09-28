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
    
    var currentRowIndex: Int = 1
    var startInRowIndex: Int = 1
    
    var startHourRowNumber: Int!
    var endHourRowNumber: Int!
    
    var selecting = false
    
    var hourModelPicker: HourModelPicker!
    
    var reservation = ReservationClass()
    
    var modelData: [HourModel] = [   HourModel(hour: 15, minute: 30, occupied: true,    occupy: false),
                                     HourModel(hour: 15, minute: 35, occupied: true,    occupy: false),
                                     HourModel(hour: 15, minute: 40, occupied: true,    occupy: false),
                                     HourModel(hour: 15, minute: 45, occupied: true,    occupy: false),
                                     HourModel(hour: 15, minute: 50, occupied: true,    occupy: false),
                                     HourModel(hour: 15, minute: 55, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 00, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 05, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 10, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 15, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 20, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 25, occupied: false,   occupy: false),
                                     HourModel(hour: 16, minute: 30, occupied: true,    occupy: false),
                                     HourModel(hour: 16, minute: 35, occupied: true,    occupy: false),
                                     HourModel(hour: 16, minute: 40, occupied: true,    occupy: false),
        ]
    var modelDataBackup: [HourModel]!
    
    //var modelData: [HourModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        startingButtonOutlet.setTitleColor(.white, for: .normal)
        
        //hourModelPicker = HourModelPicker()
        /*
        for i in 0...15{
            for j in 0...12{
                modelData.append(HourModel(hour: i, minute: j*5, occupied: false, occupy: false))
            }
        }
        */
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
        
        startInRowIndex = currentRowIndex
        endHourRowNumber = currentRowIndex
        //print(startInRowIndex)
        
        
        // if end is before start
        if startHourRowNumber > endHourRowNumber{
            endingButtonOutlet.setTitle("End", for: .normal)
            endingButtonOutlet.setTitleColor(.orange, for: .normal)
        }else if selecting == true{
            
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
        reservation.startHour = "11.00"
        reservation.endHour = "12.00"
        if reservation.endDate == ""{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIngleDateConfirmationViewController") as! SIngleDateConfirmationViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TwoDatesConfirmationViewController") as! TwoDatesConfirmationViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.reservation = self.reservation
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
