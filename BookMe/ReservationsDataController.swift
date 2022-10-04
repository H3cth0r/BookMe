//
//  ReservationsDataController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/10/22.
//

import Foundation

class ReservationDataController{
    
    let getHardwareURL      =       URL(string: "http://127.0.0.1:5000/app/api/getHardware")!
    let getSoftwareURL      =       URL(string: "http://127.0.0.1:5000/app/api/getSoftware")!
    let getRoomsURL         =       URL(string: "http://127.0.0.1:5000/app/api/getRooms")!
    let getTimeRangesURL    =       URL(string: "http://127.0.0.1:5000/app/api/getTimeRanges")!
    let getTicketsURL       =       URL(string: "http://127.0.0.1:5000/app/api/getTickets")!
    let getTicketURL        =       URL(string: "http://127.0.0.1:5000/app/api/getTicket")!
    //let getQRURL            =       URL(string: "http://127.0.0.1:5000/api/getTicket/<qr>")!
    let newTickerURL        =       URL(string: "http://127.0.0.1:5000/app/api/newTicket")!
    let deleteTicket        =       URL(string: "http://127.0.0.1:5000/app/api/deleteTicket")!
    
    
    func getHardwareObjects() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getHardwareURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String)
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([HardwareObject].self, from: data)
                print(String(response[0].identifier))
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getSoftwarebjects() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getSoftwareURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String)
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([SoftwareObject].self, from: data)
                print(String(response[0].identifier))
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getRoomobjects() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getRoomsURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String)
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([RoomObject].self, from: data)
                print(String(response[0].name))
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getTimeRanges() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTimeRangesURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String),
            "date"    :       "2022-09-30",
            "objectId":       3
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([TimeRanges].self, from: data)
                print(response)
                if(response.count > 0){
                    print(String(response[0].startDay))
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getTickets() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTicketsURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String),
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([TicketInList].self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getTicket() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTicketURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :     String(defaults.object(forKey: "userJWT") as! String),
            "ticketId":     3,
            "objectType":   "HRDWR"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(Ticket.self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func newTicket() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.newTickerURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"           :   String(defaults.object(forKey: "userJWT") as! String),
            "startDate"     :   "2022-10-02 12:00:00.000",
            "endDate"       :   "2022-09-20 12:00:00.000",
            "objectId"      :   3,
            "objectType"    :   "HRDWR",
            "objectName"    :   "Mac Book Air",
            "description"   :   "Reserva laptop APPLE"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(SavedTicketResp.self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func deleteTicket() async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.deleteTicket)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"           :   String(defaults.object(forKey: "userJWT") as! String),
            "ticketId"      :   3
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(DeletedTicketResp.self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
}

struct HardwareObject: Codable{
    let generalObjectID: Int!
    let identifier: String!
    let description: String!
    let operativeSystem: String!
    let hardwareType: String!
    let totalWeigh: Double!
}
struct SoftwareObject: Codable{
    let generalObjectID: Int!
    let identifier: String!
    let name: String!
    let brand: String!
    let description: String!
    let operativeSystem: String!
    let totalWeight: Int!
}

struct RoomObject: Codable{
    let generalObjectID: Int!
    let name: String!
    let description: String!
    let location: String!
    let capacity: Int!
    let totalWeight: Int!
}

struct TimeRanges: Codable{
    let startDate: String!
    let endDate: String!
    let startDay: String!
    let startTime: String!
    let endDay: String!
    let endTime: String!
}

struct TicketInList: Codable{
    let endDate: String!
    let objectName: String!
    let objectType: String!
    let startDate: String
    let ticketId: Int!
}
/*
 {'ticketId': 3, 'userID': 1, 'dateRegistered': '2022-09-28 15:00:00.000', 'startDate': '2022-09-30 16:00:00.000', 'endDate': '2022-09-30 16:30:00.000', 'objectId': 3, 'objectType': 'HRDWR', 'objectName': 'Mac Book Air', 'name': 'Reserva Dell ', 'qrCode': None, 'name': 'Mac Book Air', 'operativeSystem': 'macOS 12', 'objectDescription': '{\r\n"cpu" : "M1",\r\n"ports" : {"usb4" : 2, "jack" : 1},\r\n"ram" : 8,\r\n"rom": {"ssd":256}\r\n}'}
 */
struct Ticket: Codable{
    let ticketId: Int!
    let userID: Int!
    let dateRegistered: String!
    let startDate: String!
    let endDate: String!
    let objectId: Int!
    let objectType: String!
    let objectName: String!
    let name: String!
    let qrCode: String!
    // there are two names in same object
    let operativeSystem: String!
    let objectDescription: String!
}

struct SavedTicketResp: Codable{
    let ticketSaved: Bool!
}

struct DeletedTicketResp: Codable{
    let ticketDeleted: Bool!
    let errorId: Int!
}
