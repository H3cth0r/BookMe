//
//  loginViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 01/09/22.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    // Fdrmulary fields
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var surnameTextInput: UITextField!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var birthTextInput: UITextField!
    @IBOutlet weak var organizationTextInput: UITextField!
    @IBOutlet weak var mailTextInput: UITextField!
    @IBOutlet weak var countryTextInput: UITextField!
    @IBOutlet weak var phoneTextInput: UITextField!
    @IBOutlet weak var occupationTextInput: UITextField!
    @IBOutlet weak var passwordOneTextInput: UITextField!
    @IBOutlet weak var passwordTwoTextInput: UITextField!
    @IBOutlet weak var sendRegisterButtonOutlet: UIButton!
    @IBOutlet weak var endJsonOutlet: UILabel!
    
    var editingSomeTextInput = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthTextInput.inputAccessoryView = toolbar
        birthTextInput.inputView = datePicker
        birthTextInput.text = formatDate(date: Date())
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
        
        
        
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dat = formatDate(date: datePicker.date)
        birthTextInput.text = dat
        print(dat)
    }
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (self.sendRegisterButtonOutlet.frame.origin.y + sendRegisterButtonOutlet.frame.height + 200)
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
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func toVerificationButton(_ sender: UIButton) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func returnToLogOrReg(_ sender: Any) {
        vwContainer.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginOrRegisterVController") as! loginOrRegisterVController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func toTNCView(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsNConditionsViewController") as! TermsNConditionsViewController
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
