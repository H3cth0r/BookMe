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
    
    var hourModelPicker: HourModelPicker!
    
    var reservation = ReservationClass()
    /*
    let modelData: [HourModel] = [HourModel(hour: 15, minute: 30, occupied: false, occupy: false),
                                     HourModel(hour: 15, minute: 35, occupied: false, occupy: false),
                                     HourModel(hour: 15, minute: 40, occupied: false, occupy: false),
                                     HourModel(hour: 15, minute: 45, occupied: false, occupy: false),
                                     HourModel(hour: 15, minute: 50, occupied: false, occupy: false),
                                     HourModel(hour: 15, minute: 55, occupied: false, occupy: false),
                                     HourModel(hour: 16, minute: 00, occupied: false, occupy: false),
                                     HourModel(hour: 16, minute: 05, occupied: false, occupy: false),
                                     HourModel(hour: 16, minute: 10, occupied: false, occupy: false),
                                     HourModel(hour: 16, minute: 15, occupied: false, occupy: false),
        ]
        */
    var modelData: [HourModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hourModelPicker = HourModelPicker()
        for i in 0...15{
            for j in 0...12{
                modelData.append(HourModel(hour: i, minute: j*5, occupied: false, occupy: false))
            }
        }
        print(modelData.count)
        // https://www.youtube.com/watch?v=6Qd3CdWYeJ8
        // https://www.youtube.com/watch?v=lICHh10y_XU
        //hourViewPicker.delegate = hourModelPicker
        //hourViewPicker.dataSource = hourModelPicker
        hourViewPicker.delegate = self
        hourViewPicker.dataSource = self
        //hourViewPicker.delegate = ??
        // Do any additional setup after loading the view.
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
        view.heightAnchor.constraint(equalToConstant:50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 217).isActive = true
        view.setupV()
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentHourLabel.text = modelData[row].stringHour
    }
    
}
