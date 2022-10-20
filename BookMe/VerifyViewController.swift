//
//  VerifyViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit

class VerifyViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    
    var commingFromAccountConfig = false
    var commingFromLogin = false
    
    
    @IBOutlet weak var backButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !commingFromAccountConfig{
            backButtonView.isHidden = true
        }
        
        vwContainer.alpha = 0.0
        if commingFromAccountConfig{
            vwContainer.alpha = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vwContainer.fadeIn()
        }
        
        
        // fetch user data
        let userDataController  = userAccountDataController()
        let userDefaults        = UserDefaults.standard
        let username: String    = userDefaults.object(forKey: "username") as! String
        let hpass: String       = userDefaults.object(forKey: "userHashPassword") as! String

        
        if commingFromLogin{
            Task{
                await userDataController.fetchUserAccountData(username_t:username, hashPassword_t:hpass, completion: {result in
                    if(result){
                        print("Succesfull log")
                    }else{
                        print("Error on log")
                    }
                    DispatchQueue.main.async {
                        // To Main Menu after some time
                        
                        if self.commingFromAccountConfig{
                            self.vwContainer.fadeOut()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                //vc.modalTransitionStyle = .crossDissolve
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        } else{
                            self.vwContainer.fadeOut()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                //vc.modalTransitionStyle = .crossDissolve
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
        } else {
            repeatUntilVerified()
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: {
                
                Task{
                    await userDataController.fetchUserAccountData(username_t:username, hashPassword_t:hpass, completion: {result in
                        if(result){
                            print("Succesfull log")
                        }else{
                            print("Error on log")
                        }
                        DispatchQueue.main.async {
                            // To Main Menu after some time
                            
                            if self.commingFromAccountConfig{
                                self.vwContainer.fadeOut()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                    //vc.modalTransitionStyle = .crossDissolve
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true, completion: nil)
                                }
                            } else{
                                self.vwContainer.fadeOut()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                    //vc.modalTransitionStyle = .crossDissolve
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true, completion: nil)
                                }
                            }
                        }
                    })
                }
                
            })
            */
            
            
        }
        

    }
    
    
    @IBAction func goBackButton(_ sender: Any) {
        vwContainer.fadeOut()
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            //vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
         */
        
    }
    
    
    func repeatUntilVerified(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            let userDataController = userAccountDataController()
            Task{
                await userDataController.isVerified(completion:{ result in
                    if !result{
                        self.repeatUntilVerified()
                    }else{
                        // ================================================================
                        
                        
                        Task{
                            
                            // fetch user data
                            let userDataController  = userAccountDataController()
                            let userDefaults        = UserDefaults.standard
                            let loggedWithEmail     = userDefaults.object(forKey: "loggedWithEmail") as! Bool
                            let username: String!
                            if !loggedWithEmail{
                                username            = userDefaults.object(forKey: "username") as? String
                            }else{
                                username            = userDefaults.object(forKey: "userEmail") as? String
                            }
                            let hpass: String       = userDefaults.object(forKey: "userHashPassword") as! String
                            print(hpass)
                            
                            
                            await userDataController.fetchUserAccountData(username_t:username, hashPassword_t:hpass, completion: {result in
                                if(result){
                                    print("Succesfull log")
                                }else{
                                    print("Error on log")
                                }
                                DispatchQueue.main.async {
                                    // To Main Menu after some time
                                    
                                    if self.commingFromAccountConfig{
                                        self.vwContainer.fadeOut()
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                            //vc.modalTransitionStyle = .crossDissolve
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                    } else{
                                        self.vwContainer.fadeOut()
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                                            //vc.modalTransitionStyle = .crossDissolve
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                    }
                                }
                            })
                        }
                        
                        
                        // =================================================================
                    }
                })
            }
        })
    }

    
    /*
    func repeatUntilVerified(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            let userDataController = userAccountDataController()
            Task{
                await userDataController.isVerified(completion:{ result in
                    if !result{
                        self.repeatUntilVerified()
                    }else{
                        self.vwContainer.fadeOut()
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                            //vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                })
            }
        })
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
