//
//  AccountConfigViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class AccountConfigViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    // forumlary input fields
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var surnameTextInput: UITextField!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var birthTextInput: UITextField!
    @IBOutlet weak var organizationTextInput: UITextField!
    @IBOutlet weak var mailTextInput: UITextField!
    @IBOutlet weak var passwordOneTextInput: UITextField!
    @IBOutlet weak var passwordTwoTextInput: UITextField!
    
    
    @IBOutlet weak var confirmChangesView: UIView!
    
    @IBOutlet weak var mailinputspace: UITextField!
    
    
    @IBOutlet weak var sendFormOutlet: UIButton!
    
    var editingSomeTextInput = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        // adding done button to date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthTextInput.inputAccessoryView = toolbar
        birthTextInput.inputView = datePicker
        birthTextInput.text = formatDate(date: Date())
        
        // tap outside of the keyboard listeners and functionality
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
        confirmChangesView.isHidden = true
    }
    // date picker functionality
    @objc func dateChange(datePicker: UIDatePicker){
        let dat = formatDate(date: datePicker.date)
        birthTextInput.text = dat
        print(dat)
    }
    // date picker functionality
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    // date picker functionality
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (self.sendFormOutlet.frame.origin.y + sendFormOutlet.frame.height) - 90
            if editingSomeTextInput == false{
                editingSomeTextInput = true
                self.view.frame.origin.y -= keyboardHeight + bottomSpace
            }
        }
    }
    @objc func keyboardWillHide(){
        editingSomeTextInput = false
        self.view.frame.origin.y = 0
    }
    
    @IBAction func openConfirmationButton(_ sender: Any) {
        self.view.endEditing(true)
        editingSomeTextInput = false
        confirmChangesView.isHidden = false
    }
    @IBAction func saveDataButton(_ sender: Any) {
        self.view.endEditing(true)
        editingSomeTextInput = false
        confirmChangesView.isHidden = true
        if mailinputspace.text != "yledo@tec.mx" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                //vc.modalTransitionStyle = .crossDissolve
                vc.commingFromAccountConfig = true
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func cancelChangesButton(_ sender: Any) {
        confirmChangesView.isHidden = true
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
