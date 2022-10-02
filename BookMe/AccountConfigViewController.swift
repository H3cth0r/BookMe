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
    
    
    @IBOutlet weak var confirmChangesView: UIView!
    
    @IBOutlet weak var mailinputspace: UITextField!
    
    @IBOutlet weak var sendFormOutlet: UIButton!
    
    // user profile photo image outlet
    @IBOutlet weak var userProfilePhoto: UIImageView!
    
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
        if(nameTextInput.text != oldNameText || surnameTextInput.text != oldSurnameText || usernameTextInput.text != oldUsernameText || birthTextInput.text != oldBirthText || organizationTextInput.text != oldOrganizationText || mailinputspace.text != oldMailText || passwordOneTextInput.text != oldPasswordOneText || passwordTwoTextInput.text != oldPassqoesTwoText){
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
        }
        
        // Image picker for camera
        let libraryAction = UIAlertAction(title: "Library", style: .default){[weak self] (ACTION) in
            guard let self = self else{
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)    // <<<<<<<<<<<<<<<
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true)
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


