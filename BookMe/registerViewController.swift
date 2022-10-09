//
//  registerViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 01/09/22.
//

import UIKit
import SwiftJWT

class registerViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    // input fields
    @IBOutlet weak var usernameOrMailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    
    // input fields labels
    @IBOutlet weak var usernameOrMailInputFieldLabel: UILabel!
    @IBOutlet weak var passwordInputFieldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        vwContainer.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
    }
    
    @IBAction func toVerificationButton(_ sender: UIButton) {
        let userDataController = userAccountDataController()
        let str: String = passwordInputField.text ?? ""
        let hashedP = ccSha256(data: str.data(using: .utf8)!)
        let thePassword = String(hashedP.map{ String(format: "%02hhx", $0) }.joined())
        //var res: (Bool?)->Void
        

        // if(validateInputFields())
        if(true){
            
            // save user and password to defaults, to be used in verify
            let defaults = UserDefaults.standard
            defaults.set(self.usernameOrMailInputField.text, forKey: "username")
            defaults.set(thePassword,           forKey: "hashPassword")
            
            Task{
                await userDataController.loginWithCredentials(username_t: usernameOrMailInputField.text ?? "", hashPassword_t: thePassword, completion: {result in
                    if(result){
                        print("we did it")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                            //vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                        //self.something = "pisis"
                    }else{
                        print("not nice")
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
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func validateInputFields()->Bool{
        var allOk = true
        if(isValidEmail(usernameOrMailInputField.text ?? "Pepo117@tec.mx")){
            usernameOrMailInputFieldLabel.textColor = .white
        } else{
            usernameOrMailInputFieldLabel.textColor = .red
            allOk = false
            if(isValidUsername(usernameOrMailInputField.text ?? "Pepo117")){
                usernameOrMailInputFieldLabel.textColor = .white
                allOk = true
            }
        }
        
        if(!isValidPassword(password: passwordInputField.text ?? "p")){
            allOk = false
            passwordInputFieldLabel.textColor = .red
        } else {
            passwordInputFieldLabel.textColor = .white
        }
        
        
        
        return allOk
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
