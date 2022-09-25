//
//  HourModelPicker.swift
//  BookMe
//
//  Created by Héctor Miranda García on 24/09/22.
//

import UIKit

class HourModelPicker: UIPickerView {
    
    var modelData: [HourModel]!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension HourModelPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
    
}

extension HourModelPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
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
}
