//
//  ReservationsDataController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 03/10/22.
//

import Foundation

class ReservationDataController{
    
    let getHardwareURL          =       URL(string: "http://4.228.81.149:5000/app/api/getHardware")!
    let getSoftwareURL          =       URL(string: "http://4.228.81.149:5000/app/api/getSoftware")!
    let getRoomsURL             =       URL(string: "http://4.228.81.149:5000/app/api/getRooms")!
    let getTimeRangesURL        =       URL(string: "http://4.228.81.149:5000/app/api/getTimeRanges")!
    let getTicketsURL           =       URL(string: "http://4.228.81.149:5000/app/api/getTickets")!
    let getTicketURL            =       URL(string: "http://4.228.81.149:5000/app/api/getTicket")!
    let newTickerURL            =       URL(string: "http://4.228.81.149:5000/app/api/newTicket")!
    let deleteTicket            =       URL(string: "http://4.228.81.149:5000/app/api/deleteTicket")!
    let getTimeRangesForDaysURL =       URL(string: "http://4.228.81.149:5000/app/api/getTimeRangesForDays")!
    
    
    func getHardwareObjects(completion: @escaping ([HardwareObject])->Void) async{
        
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
                completion(response)
            } catch{
                print(error)
                completion([HardwareObject(generalObjectID: 0, identifier: "none", description: "none", operativeSystem: "none", hardwareType: "none", totalWeigh: 0, maxDays: 0)])
            }
        }
        task.resume()
    }
    
    func getSoftwarebjects(completion: @escaping ([SoftwareObject])->Void) async{
        
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
                completion(response)
            } catch{
                print(error)
                completion([SoftwareObject(generalObjectID: 0, identifier: "none", name: "none", brand: "node", description: "node", operativeSystem: "none", totalWeight: 0, maxDays: 0)])
            }
        }
        task.resume()
    }
    
    func getRoomobjects(completion: @escaping ([RoomObject])->Void) async{
        
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
                completion(response)
            } catch{
                print(error)
                completion([RoomObject(generalObjectID: 0, name: "none", description: "none", location: "none", capacity: 0, totalWeight: 0, maxDays: 0)])
            }
        }
        task.resume()
    }
    
    
    func getTimeRanges(theDate: String, objID: Int, completion: @escaping ([TimeRanges])->Void) async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTimeRangesURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :       String(defaults.object(forKey: "userJWT") as! String),
            "date"    :       theDate,
            "objectId":       objID
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
               completion(response)
            } catch{
                print(error)
                completion([TimeRanges(startDate: "none", endDate: "none", startDay: "none", startTime: "none", endDay: "none", endTime: "none")])
            }
        }
        task.resume()
    }
    
    func getTimeRangesForDays(objectId: Int, completion: @escaping ([TimeRanges])->Void){
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTimeRangesForDaysURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 30, to: startDate) ?? Date()
        print("SD\(dateFormatterGet.string(from: startDate)) , ED\(dateFormatterGet.string(from: endDate))")
        let body: [String: AnyHashable] =   [
            "jwt"       :       String(defaults.object(forKey: "userJWT") as! String),
            "startDate" :       dateFormatterGet.string(from: startDate),
            "endDate"   :       dateFormatterGet.string(from: endDate),
            "objectId"  :       objectId
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode([TimeRanges].self, from: data)
                print("THE RESPONSE: \(response)")
               completion(response)
            } catch{
                print(error)
                completion([TimeRanges(startDate: "none", endDate: "none", startDay: "none", startTime: "none", endDay: "none", endTime: "none")])
            }
        }
        task.resume()
    }
    
    func getTickets(completion: @escaping ([TicketInList])->Void) async{
        
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
                completion(response)
            } catch{
                print(error)
                completion([TicketInList(endDate: "none", objectName: "none", objectType: "none", startDate: "none", ticketId: 0)])
            }
        }
        task.resume()
    }
    
    func getTicket(objId: Int, objTyp: String, completion: @escaping (Ticket)->Void) async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.getTicketURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"     :     String(defaults.object(forKey: "userJWT") as! String),
            "ticketId":     objId,
            "objectType":   objTyp
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(Ticket.self, from: data)
                completion(response)
            } catch{
                print(error)
                completion(Ticket(ticketId: 0, userID: 0, dateRegistered: "none", startDate: "none", endDate: "none", objectId: 0, objectType: "none", objectName: "none", name: "none", qrCode: "none", qrCode64: "none", operativeSystem: "none", objectDescription: "none", weight: 0))
            }
        }
        task.resume()
    }
    
    func newTicket(startDate_t: String, endDate_t: String, objectId_t: Int, objectType_t: String, objectName_t: String, description_t: String,completion: @escaping (SavedTicketResp)->Void) async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.newTickerURL)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"           :   String(defaults.object(forKey: "userJWT") as! String),
            "startDate"     :   startDate_t,
            "endDate"       :   endDate_t,
            "objectId"      :   objectId_t,
            "objectType"    :   objectType_t,
            "objectName"    :   objectName_t,
            "description"   :   description_t
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
                completion(response)
            } catch{
                print(error)
                completion(SavedTicketResp(ticketSaved: false))
            }
        }
        task.resume()
    }
    
    func deleteTicket(tickedId: Int, completion: @escaping (DeletedTicketResp)->Void) async{
        
        let defaults        =       UserDefaults.standard
        
        var request         =       URLRequest(url: self.deleteTicket)
        request.httpMethod  =       "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] =   [
            "jwt"           :   String(defaults.object(forKey: "userJWT") as! String),
            "ticketId"      :   tickedId
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
                completion(response)
            } catch{
                print(error)
                completion(DeletedTicketResp(ticketDeleted: false, errorId: 0))
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
    let maxDays: Int!
}
struct SoftwareObject: Codable{
    let generalObjectID: Int!
    let identifier: String!
    let name: String!
    let brand: String!
    let description: String!
    let operativeSystem: String!
    let totalWeight: Double!
    let maxDays: Int!
}

struct RoomObject: Codable{
    let generalObjectID: Int!
    let name: String!
    let description: String!
    let location: String!
    let capacity: Int!
    let totalWeight: Double!
    let maxDays: Int!
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
    let qrCode64: String!
    // there are two names in same object
    let operativeSystem: String!
    let objectDescription: String!
    let weight: Double!
}

struct SavedTicketResp: Codable{
    let ticketSaved: Bool!
}

struct DeletedTicketResp: Codable{
    let ticketDeleted: Bool!
    let errorId: Int!
}


