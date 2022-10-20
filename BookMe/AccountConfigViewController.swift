//
//  AccountConfigViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class AccountConfigViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    
    // formulary input field label
    @IBOutlet weak var nameTextInputLabel: UILabel!
    @IBOutlet weak var surnameTextInputLabel: UILabel!
    @IBOutlet weak var usernameTextInputLabel: UILabel!
    @IBOutlet weak var birthTextInputLabel: UILabel!
    @IBOutlet weak var organizationTextInputLabel: UILabel!
    @IBOutlet weak var labelTextInputLabel: UILabel!
    @IBOutlet weak var passwordOneTextInputLabel: UILabel!
    @IBOutlet weak var passwordTwoTextInputLabel: UILabel!
    
    
    // forumlary input fields
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var surnameTextInput: UITextField!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var birthTextInput: UITextField!
    @IBOutlet weak var organizationTextInput: UITextField!
    @IBOutlet weak var mailTextInput: UITextField!
    @IBOutlet weak var passwordOneTextInput: UITextField!
    @IBOutlet weak var passwordTwoTextInput: UITextField!
    
    // Old textfield values
    var oldNameText: String!
    var oldSurnameText: String!
    var oldUsernameText: String!
    var oldBirthText: String!
    var oldOrganizationText: String!
    var oldMailText: String!
    var oldPasswordOneText: String!
    var oldPassqoesTwoText: String!
    
    // password for verification
    @IBOutlet weak var inputPasswordVerification: UITextField!
    
    
    @IBOutlet weak var confirmChangesView: UIView!
    
    @IBOutlet weak var mailinputspace: UITextField!
    
    @IBOutlet weak var sendFormOutlet: UIButton!
    
    // user profile photo image outlet
    @IBOutlet weak var userProfilePhoto: UIImageView!
    
    // Bool for checking if user is chaning profile picture
    var changedProfilePicture = false
    
    
    var editingSomeTextInput = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creaating task to fetch current saved user data and apply
        // data to the input views
        Task{
            let userAccountDataController = userAccountDataController()
            let defaults = UserDefaults.standard
            let username_t: String!
            let loggedWithEmail         = defaults.object(forKey: "loggedWithEmail") as! Bool
            if !loggedWithEmail{
                username_t             = defaults.object(forKey: "username") as? String
            }else{
                username_t            = defaults.object(forKey: "userEmail") as? String
                print("USERNAME TTTTTT = \(username_t)")
            }
            
            let hashpwd_t = defaults.object(forKey: "userHashPassword") as! String
            await userAccountDataController.fetchUserAccountData(username_t: username_t as! String, hashPassword_t: hashpwd_t as! String, completion: { result in
                
                let defaults                = UserDefaults.standard
                self.oldNameText            = defaults.object(forKey: "userFirstName")  as? String
                self.oldSurnameText         = defaults.object(forKey: "userLastName")   as? String
                self.oldUsernameText        = defaults.object(forKey: "username")       as? String
                self.oldBirthText           = defaults.object(forKey: "birthDate")      as? String
                self.oldOrganizationText    = defaults.object(forKey: "organization")   as? String
                self.oldMailText            = defaults.object(forKey: "userEmail")      as? String
                self.oldPasswordOneText     = ""
                self.oldPassqoesTwoText     = ""
                DispatchQueue.main.async {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateFormatterRead = DateFormatter()
                    dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                    let formatedDate = dateFormatterRead.date(from: self.oldBirthText)
                    
                    // profile picture
                    let pfp = defaults.object(forKey: "pfp") as? String
                    let dataDecoded : Data = Data(base64Encoded: pfp!, options: .ignoreUnknownCharacters)!
                    let decodedimage = UIImage(data: dataDecoded)
                    self.userProfilePhoto.image = decodedimage
                    
                    self.nameTextInput.text         = self.oldNameText
                    self.surnameTextInput.text      = self.oldSurnameText
                    self.usernameTextInput.text     = self.oldUsernameText
                    self.birthTextInput.text        = dateFormatter.string(from: formatedDate!)
                    self.organizationTextInput.text = self.oldOrganizationText
                    self.mailTextInput.text         = self.oldMailText
                    
                    self.setOldValues()
                }
            })
            
        }
        
        // creating date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        // User profile picture selection configuration
        let tapImageGR = UITapGestureRecognizer(target: self, action: #selector(self.showImagePickerOptions))
        userProfilePhoto.addGestureRecognizer(tapImageGR)
        userProfilePhoto.isUserInteractionEnabled = true
        
        // check if user has saved an image on user defaults
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "profilePicture") != nil {
            userProfilePhoto.image = UIImage(data: defaults.object(forKey: "profilePicture") as! Data)
        }

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
        
        // Saving starting values to oldvalues
        setOldValues()
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
        if(checkDataChanges() && thereAreChanges()){
            confirmChangesView.isHidden = false
        }
        
    }
    @IBAction func saveDataButton(_ sender: Any) {
        
        
        // first must login, with the old password
        Task{
            let userDataController = userAccountDataController()
            let defaults = UserDefaults.standard
            let username_t: String!
            
            let loggedWithEmail         = defaults.object(forKey: "loggedWithEmail") as! Bool
            if !loggedWithEmail{
                username_t             = defaults.object(forKey: "username") as? String
            }else{
                username_t            = defaults.object(forKey: "userEmail") as? String
                print(loggedWithEmail)
                print("username_t === \(username_t)")
            }
            
            let str: String = self.inputPasswordVerification.text ?? ""
            let hashedP = ccSha256(data: str.data(using: .utf8)!)
            let thePassword = String(hashedP.map{ String(format: "%02hhx", $0) }.joined())
            
            await userDataController.loginWithCredentials(username_t: username_t, hashPassword_t: thePassword, completion: {result in
                
                print(result)
                if !result{
                    return
                }else{
                    DispatchQueue.main.async {
                        
                        self.registerTheNewData()
                    }
                }
                
            })
        }
        
        
        /*
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
         */
    }
    
    func registerTheNewData(){
        Task{
            let userDataController  = userAccountDataController()
            let defaults            = UserDefaults.standard
            let jwt_t               = defaults.object(forKey: "userJWT")  as! String
            let hashp_t             = defaults.object(forKey: "userHashPassword") as! String
            let firstName_t         = self.nameTextInput.text
            let lastName_t          = self.surnameTextInput.text
            let username_t          = self.usernameTextInput.text
            let birthDate_t         = self.birthTextInput.text! + " 00:00:00.000"
            let organization_t      = self.organizationTextInput.text
            let email_t             = self.mailTextInput.text
            let newHashPassword     = self.passwordOneTextInput.text
            let imageData           = userProfilePhoto.image?.jpegData(compressionQuality: 1)
            let imageBase64String = imageData?.base64EncodedString()
            let pfp_t               = imageBase64String as! String
            
            
            await userDataController.saveNewData(jwt_t: jwt_t, oldHashPassword_t: hashp_t, firstName_t: firstName_t!, lastName_t: lastName_t!, username_t: username_t!, birthDate_t: birthDate_t, organization_t: organization_t!, email_t: email_t!, hashPassword_t: newHashPassword!, pfp_t: pfp_t, completion: {result in
                print("SAVED? \(result)")
                
                    
                    // present verify screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        if self.oldMailText != self.mailTextInput.text{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                            vc.modalPresentationStyle = .fullScreen
                            vc.commingFromAccountConfig = true
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                        self.oldNameText            = self.nameTextInput.text
                        self.oldSurnameText         = self.surnameTextInput.text
                        self.oldUsernameText        = self.usernameTextInput.text
                        self.oldBirthText           = self.birthTextInput.text
                        self.oldOrganizationText    = self.organizationTextInput.text
                        self.oldMailText            = self.mailTextInput.text
                        
                        // hide confirmation view
                        self.confirmChangesView.isHidden = true
                        
                        // change profile picture = false
                        self.changedProfilePicture = false
                        
                    }

                
            })
        }
    }
    
    
    @IBAction func cancelChangesButton(_ sender: Any) {
        confirmChangesView.isHidden = true
    }
    
    func setOldValues(){
        oldNameText         = nameTextInput.text
        oldSurnameText      = surnameTextInput.text
        oldUsernameText     = usernameTextInput.text
        oldBirthText        = birthTextInput.text
        oldOrganizationText = organizationTextInput.text
        oldMailText         = mailinputspace.text
        oldPasswordOneText  = passwordOneTextInput.text
        oldPassqoesTwoText  = passwordTwoTextInput.text
    }
    
    func thereAreChanges()->Bool{
        if(nameTextInput.text != oldNameText || surnameTextInput.text != oldSurnameText || usernameTextInput.text != oldUsernameText || birthTextInput.text != oldBirthText || organizationTextInput.text != oldOrganizationText || mailinputspace.text != oldMailText || passwordOneTextInput.text != oldPasswordOneText || passwordTwoTextInput.text != oldPassqoesTwoText || self.changedProfilePicture == true){
            return true
        }
        return false
    }
    
    // Check user input fields data
    func checkDataChanges()->Bool{
        
        var allOkay = true
        
        // setting default color
        nameTextInputLabel.textColor = .black
        surnameTextInputLabel.textColor = .black
        usernameTextInputLabel.textColor = .black
        labelTextInputLabel.textColor = .black
        passwordOneTextInputLabel.textColor = .black
        passwordTwoTextInputLabel.textColor = .black
        
        if(oldNameText != nameTextInput.text){
            let currentName = nameTextInput.text ?? "Pepo"
            if !isValidName(currentName){
                nameTextInputLabel.textColor = .red
                allOkay = false
            }else{
                nameTextInputLabel.textColor = .black
            }
        }
        
        if(surnameTextInput.text != oldSurnameText){
            let currentSurname = surnameTextInput.text ?? "Smith"
            if !isValidName(currentSurname){
                surnameTextInputLabel.textColor = .red
                allOkay = false
            }else{
                surnameTextInputLabel.textColor = .black
            }
        }
        
        if(oldUsernameText != usernameTextInput.text){
            // service to check if username exists
            let currentUsername = usernameTextInput.text ?? "pepo117"
            if !isValidUsername(currentUsername){
                usernameTextInputLabel.textColor = .red
                allOkay = false
            }else{
                usernameTextInputLabel.textColor = .black
            }
            print(usernameTextInput.text ?? "none")
        }
        
        if(oldMailText != mailinputspace.text){
            // check if valid mail
            let currentMail = mailinputspace.text ?? "work@gmail.com"
            if(!isValidEmail(currentMail)){
                labelTextInputLabel.textColor = .red
                allOkay = false
            }else{
                labelTextInputLabel.textColor = .black
            }
            
        }
        
        if(oldPasswordOneText != passwordOneTextInput.text || oldPassqoesTwoText != passwordTwoTextInput.text){
            //  check password structure
            let currentPassword = passwordOneTextInput.text ?? "pepito22@smith"
            if(!isValidPassword(password: currentPassword)){
                passwordOneTextInputLabel.textColor = .red
                passwordTwoTextInputLabel.textColor = .red
                allOkay = false
            }else{
                passwordOneTextInputLabel.textColor = .black
                passwordTwoTextInputLabel.textColor = .black
            }
            if(passwordOneTextInput.text != passwordTwoTextInput.text){
                // just color the second, to indicate they are not the same
                passwordTwoTextInputLabel.textColor = .red
                allOkay = false
            }else{
                passwordTwoTextInputLabel.textColor = .black
            }
        }
        
        return allOkay
        
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
    
    @objc func showImagePickerOptions(){
        let alertVC = UIAlertController(title: "Pick your best angle", message: "Pick your best angle", preferredStyle: .actionSheet)
        
        // Image picker for camera
        let cameraAction = UIAlertAction(title: "Camera", style: .default){[weak self] (ACTION) in
            guard let self = self else{
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true)
            
            // The user is maing a change in his profile picture
            self.changedProfilePicture = true
        }
        
        // Image picker for camera
        let libraryAction = UIAlertAction(title: "Library", style: .default){[weak self] (ACTION) in
            guard let self = self else{
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)    // <<<<<<<<<<<<<<<
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true)
            
            // The user is maing a change in his profile picture
            self.changedProfilePicture = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
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


// extension for the image selection
extension AccountConfigViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.originalImage] as! UIImage
        print(info[.imageURL] ?? "lol")
        
        // save image url to userdefaults
        let defaults = UserDefaults.standard
        //defaults.set(info[.imageURL], forKey: "profilePictureURL")
        let dataImage = image.pngData()
        defaults.set(dataImage, forKey: "profilePicture")
        
        self.userProfilePhoto.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


