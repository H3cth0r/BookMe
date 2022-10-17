//
//  loginViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 01/09/22.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    // terms n conditions button
    @IBOutlet weak var termsNConditionsButtonOutlet: UIButton!
    
    
    // Fdrmulary fields
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var surnameTextInput: UITextField!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var birthTextInput: UITextField!
    @IBOutlet weak var organizationTextInput: UITextField!
    @IBOutlet weak var mailTextInput: UITextField!
    @IBOutlet weak var countryTextInput: UITextField!
    @IBOutlet weak var occupationTextInput: UITextField!
    @IBOutlet weak var passwordOneTextInput: UITextField!
    @IBOutlet weak var passwordTwoTextInput: UITextField!
    // other
    @IBOutlet weak var sendRegisterButtonOutlet: UIButton!
    @IBOutlet weak var endJsonOutlet: UILabel!
    // Formulary fields labels
    @IBOutlet weak var nameTextInputLabel: UILabel!
    @IBOutlet weak var surnameTextInputLabel: UILabel!
    @IBOutlet weak var usernameTextInputLabel: UILabel!
    @IBOutlet weak var birthTextInputLabel: UILabel!
    @IBOutlet weak var organizationTextInputLabel: UILabel!
    @IBOutlet weak var mailTextInputLabel: UILabel!
    @IBOutlet weak var countryTextInputLabel: UILabel!
    @IBOutlet weak var occupationTextInputLabel: UILabel!
    @IBOutlet weak var passwordOneTextInputLabel: UILabel!
    @IBOutlet weak var passwordTwoTextInputLabel: UILabel!
    
    
    
    var editingSomeTextInput = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling text terms n conditions
        termsNConditionsButtonOutlet.titleLabel?.font = UIFont(name: "Chivo-Regular", size: 11)
        
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
        
        // touch outside keyboard listeners
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
            let bottomSpace = self.view.frame.height - (self.sendRegisterButtonOutlet.frame.origin.y + sendRegisterButtonOutlet.frame.height + 150)
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
        let userDataController = userAccountDataController()
        
        // if fields inputs are okay, do this
        if(validateFieldsInput()){
            Task{
                await userDataController.registerNewUser(firstName_t: nameTextInput.text ?? "", lastName_t: surnameTextInput.text ?? "", username_t: usernameTextInput.text ?? "",birthDate_t: (birthTextInput.text ?? "") + " 14:00:00.000000", organization_t: organizationTextInput.text ?? "", mail_t: mailTextInput.text ?? "", ocupation_t: occupationTextInput.text ?? "", countryId_t: countryTextInput.text ?? "", password_t: passwordOneTextInput.text ?? "", completion: {result in
                    if(result){
                        print("registered")
                        
                        let str: String = self.passwordOneTextInput.text ?? ""
                        let hashedP = ccSha256(data: str.data(using: .utf8)!)
                        let thePassword = String(hashedP.map{ String(format: "%02hhx", $0) }.joined())
                        
                        let defaults = UserDefaults.standard
                        defaults.set(self.usernameTextInput.text, forKey: "username")
                        defaults.set(thePassword,           forKey: "hashPassword")
                        self.vwContainer.fadeOut()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                            //vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }else{
                        print("not registered bruh")
                    }
                })
            }
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
        termsNConditionsButtonOutlet.titleLabel?.font = UIFont(name: "Chivo-Regular", size: 11)
    }
    func validateFieldsInput()->Bool{
        var allOk = true
        
        // validate name
        if(!isValidName(nameTextInput.text ?? "Pepo")){
            allOk = false
            nameTextInputLabel.textColor = .red
        } else {
            nameTextInputLabel.textColor = .white
        }
        
        // validate surname
        if(!isValidName(surnameTextInput.text ?? "Smith")){
            allOk = false
            surnameTextInputLabel.textColor = .red
        } else {
            surnameTextInputLabel.textColor = .white
        }
        
        // validate username
        if(!isValidUsername(usernameTextInput.text ?? "Pepo117")){
            allOk = false
            usernameTextInputLabel.textColor = .red
        }else {
            usernameTextInputLabel.textColor = .white
        }
        
        // validatate organization
        if(!isValidUsername(organizationTextInput.text ?? "Facebook")){
            allOk = false
            organizationTextInputLabel.textColor = .red
        } else {
            organizationTextInputLabel.textColor = .white
        }
        
        // valdiate mail
        if(!isValidEmail(mailTextInput.text ?? "elPepo@tec.mx")){
            allOk = false
            mailTextInputLabel.textColor = .red
        } else {
            mailTextInputLabel.textColor = .white
        }
        
        // is valid country
        if(!isValidName(countryTextInput.text ?? "México")){
            allOk = false
            countryTextInputLabel.textColor = .red
        } else {
            countryTextInputLabel.textColor = .white
        }
        
        // is valid occupation
        if(!isValidName(occupationTextInput.text ?? "Developer")){
            allOk = false
            occupationTextInputLabel.textColor = .red
        } else {
            occupationTextInputLabel.textColor = .white
        }
        
        // validate passowrd one
        if(!isValidPassword(password: passwordOneTextInput.text ?? "Pepo117@2022")){
            allOk = false
            passwordOneTextInputLabel.textColor = .red
            passwordOneTextInputLabel.textColor = .red
        } else {
            passwordOneTextInputLabel.textColor = .white
            passwordTwoTextInputLabel.textColor = .white
        }
        
        // validate password two
        if(passwordOneTextInput.text != passwordTwoTextInput.text){
            allOk = false
            passwordTwoTextInputLabel.textColor = .red
        } else {
            passwordTwoTextInputLabel.textColor = .white
        }
        
        return allOk
    }
    
    func isValidName(_ name: String) -> Bool {
        //Declaring the rule of characters to be used. Applying rule to current state. Verifying the result.
        let regex = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: name)
        
        return result
    }
    func isValidUsername(_ username:String) -> Bool {
        let RegEx = "\\w{7,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: username)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    // https://stackoverflow.com/questions/57771505/use-regex-to-validate-a-password-on-ios-swift
    func isValidPassword(password: String) -> Bool {
        let passRegEx = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
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
