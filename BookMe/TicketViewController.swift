//
//  TicketViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/09/22.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var jsonReservationInfo: UILabel!
    @IBOutlet weak var confirmationNumberLabel: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    var hardwareObj: HardwareObject!
    var softwareObj: SoftwareObject!
    var spaceObj: RoomObject!
    
    var aaa = ""
    var bbb = ""
    
    var reservation = ReservationClass()
    var theTicketId: Int!
    var theObjectType: String!
    var recivedTicket: Ticket!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task{
            let reservationDataController = ReservationDataController()
            await reservationDataController.getTicket(objId: self.theTicketId, objTyp: self.theObjectType, completion: { result in
                self.recivedTicket = result
                //print("RESULT")
                //print(result)
                DispatchQueue.main.async {
                    
                    let jsonResult = """
                                     reservation: {
                                     
                                     \tdate_registered: \(String(self.recivedTicket.dateRegistered)),
                                     
                                     \tstart_date: \(String(self.recivedTicket.startDate)),
                                     
                                     \tend_date: \(String(self.recivedTicket.endDate)),
                                     
                                     \tobject_type: \(String(self.recivedTicket.objectType)),
                                     
                                     \tobject_name: \(String(self.recivedTicket.objectName))
                                     
                                     }
                                     """
                    
                    self.jsonReservationInfo.text = jsonResult
                    self.confirmationNumberLabel.text = "#\(String(self.recivedTicket.qrCode))"
                    
                    let dataDecoded : Data = Data(base64Encoded: String(self.recivedTicket.qrCode64), options: .ignoreUnknownCharacters)!
                    let decodedimage = UIImage(data: dataDecoded)
                    self.qrCodeImageView.image = decodedimage
                }
                                
            })
        }
        
        
    }
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        
        // add ignore ticket to get ranges
        let dateFormatterRead = DateFormatter()
        dateFormatterRead.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let sd = dateFormatterRead.date(from: String(recivedTicket.startDate))
        let ed = dateFormatterRead.date(from: String(recivedTicket.endDate))
        //print(recivedTicket)
        
        // set object type to reservation
        if recivedTicket.objectType == "HRDWR"{
            reservation.theTypeOfObject = "Hardware"
        }else if recivedTicket.objectType == "SFTWR"{
            reservation.theTypeOfObject = "Software"
        }else{
            reservation.theTypeOfObject = "Space"
        }
        
        // if it is the same day and the hours are not the same, then go to hour selection
        if isSameDay(date1: sd ?? Date(), date2: ed ?? Date()) && sd != ed{
            print("hour selection")
            reservation.multipleDays = false
        }else{
            print("day selection")
            reservation.multipleDays = true
        }
        
        // get all objects of the type to find if the
        Task{
            let reservationDataController = ReservationDataController()
            
            if recivedTicket.objectType == "HRDWR"{
                await reservationDataController.getHardwareObjects(completion: { result in
                    let id = self.recivedTicket.objectId
                    for i in result{
                        if i.generalObjectID == id{
                            self.hardwareObj = i
                        }
                    }
                    self.reservation.hardwareObject = self.hardwareObj
                    
                    DispatchQueue.main.async {
                        if self.reservation.multipleDays {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
                            vc.reservation = self.reservation
                            vc.userEditing = true           // <---------------
                            vc.reservation.recivedTicket = self.recivedTicket
                            vc.reservation.objectTypeReservation = "Hardware"
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                            vc.reservation = self.reservation
                            vc.userEditing = true           // <---------------
                            vc.reservation.recivedTicket = self.recivedTicket
                            vc.reservation.objectTypeReservation = "Hardware"
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    
                    }
                    
                    
                })
            }else if recivedTicket.objectType == "SFTWR"{
                await reservationDataController.getSoftwarebjects(completion: { result in
                    let id = self.recivedTicket.objectId
                    for i in result{
                        if i.generalObjectID == id{
                            self.softwareObj = i
                        }
                    }
                    
                    self.reservation.softwareObject = self.softwareObj
                    
                    DispatchQueue.main.async {
                        if self.reservation.multipleDays {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "twoDatesSelectionViewController") as! twoDatesSelectionViewController
                            vc.reservation = self.reservation
                            vc.userEditing = true           // <---------------
                            vc.reservation.recivedTicket = self.recivedTicket
                            vc.reservation.objectTypeReservation = "Software"
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "oneDateSelectionViewController") as! oneDateSelectionViewController
                            vc.reservation = self.reservation
                            vc.userEditing = true           // <---------------
                            vc.reservation.recivedTicket = self.recivedTicket
                            vc.reservation.objectTypeReservation = "Software"
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    
                    }
                })
            }else{
                await reservationDataController.getRoomobjects(completion: { result in
                    let id = self.recivedTicket.objectId
                    for i in result{
                        if i.generalObjectID == id{
                            self.spaceObj = i
                        }
                    }
                    
                    self.reservation.roomObject = self.spaceObj
                    
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumberOfAssistantsViewController") as! NumberOfAssistantsViewController
                        vc.reservation = self.reservation
                        vc.reservation.objectTypeReservation = "Space"
                        vc.userEditing = true
                        vc.recivedTicket = self.recivedTicket
                        vc.reservation.maxNumberOfAssistans = self.reservation.roomObject.capacity
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                })
            }
            
        }
        
        
    }
    
    func updateLabels(){
        /*
        var jsonToPresent = """
                            dateRegistered: \(String(self.recivedTicket.dateRegistered))
                            startDate: \(String(self.recivedTicket.startDate))
                            endDate: \(String(self.recivedTicket.endDate))
                            objectType: \(String(self.recivedTicket.objectType))
                            objectName: \(String(self.recivedTicket.objectName))
                            """
        */
        
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
