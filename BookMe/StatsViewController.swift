//
//  StatsViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 05/09/22.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var totalMinutes: UILabel!
    @IBOutlet weak var totalReservations: UILabel!
    @IBOutlet weak var favObject: UILabel!
    @IBOutlet weak var timesReservedFavObject: UILabel!
    @IBOutlet weak var daysSinceRegister: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Task{
            let userAccountData = userAccountDataController()
            let defaults = UserDefaults.standard
            let jwt_t = defaults.object(forKey: "userJWT")  as! String
            await userAccountData.getPersonalStats(jwt_t: jwt_t, completion: { result in
                DispatchQueue.main.async {
                    self.totalMinutes.text              = String(Int(result.totalHoursReserved))
                    self.totalReservations.text         = String(Int(result.totalReservations))
                    self.favObject.text                 = String(result.favObjectType)
                    self.timesReservedFavObject.text    = String(Int(result.favObjectTypeReservations))
                    self.daysSinceRegister.text         = String(Int(result.daysSinceRegister))
                }
            })
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
