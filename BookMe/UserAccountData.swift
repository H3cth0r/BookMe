//
//  UserAccountData.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/10/22.
//

import Foundation
import SwiftJWT

enum UserAccountDataError: Error, LocalizedError{
    case itemNotFound
    case decodeError
}

class UserAccountData{
    var user_jwtTokenSession = ""
    var user_name: String!
    var user_surname: String!
    var user_username: String!
    var user_birth: String!
    var user_organization: String!
    var user_mail: String!
    var user_country: String!
    var user_occupation: String!
}

class userAccountDataController{
    let baseURL             =   URL(string: "http://127.0.0.1:5000/app/api/login")!
    //let baseURL             =   URL(string: "http://4.228.81.149:5000/app/api/login")!
    //let mailOrUsername      =   "A01659891@tec.mx"
    let mailOrUsername      =   "pepo117"
    let hashPassword        =   "d50d3319bccca99d3093b689745b168cc79ecfd0e18e3e80be6d8c6ad1061407"
    
    func fetchUserAccountData() async{
        
        //var allOk = true
        
        // request from base URL
        var request         =   URLRequest(url: self.baseURL)
        
        // Method body headers
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "username"     : self.mailOrUsername,
            "password"  : self.hashPassword
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                //let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let responseTwo = try JSONDecoder().decode(UserDataResponse.self, from: data)
                //print("SUCCESS: \(response)")
                //print("SUCCESS: \(responseTwo)")
                //print("THIS IS THE JWT \(String(responseTwo.jwt))")
                
                let jwtVerifier = JWTVerifier.hs256(key: Data("BooKMeIsCool".utf8))
                let jwtDecoder = JWTDecoder(jwtVerifier: jwtVerifier)
                let jwt = try jwtDecoder.decode(JWT<UserDataDecoded>.self, fromString: responseTwo.jwt)
                //print(String(jwt.claims.lastName))
                //let UDO = UserDataObject(id: Int(jwt.claims.id ?? 1), email: String(jwt.claims.email), firstName: String(jwt.claims.firstName), lastName: String(jwt.claims.lastName), hashPassword: String(jwt.claims.hashPassword ?? "sdfsf"), admin: Int(jwt.claims.admin), blocked: Int( jwt.claims.blocked))

                // save claims to defaults(jwt)
                let defaults = UserDefaults.standard
                
                defaults.set(String(jwt.claims.firstName),      forKey: "userFirstName")
                defaults.set(String(jwt.claims.lastName),       forKey: "userLastName")
                defaults.set(String(jwt.claims.email),          forKey: "userEmail")
                defaults.set(Int(jwt.claims.id ?? 1),             forKey: "userId")
                defaults.set(String(jwt.claims.hashPassword ?? "sdfsf"),   forKey: "userHashPassword")
                defaults.set(Int(   jwt.claims.admin),          forKey: "userIsAdmin")
                defaults.set(Int(   jwt.claims.blocked),        forKey: "userIsBlocked")
                 
                
                if defaults.object(forKey: "userFirstName") != nil{
                    print(defaults.object(forKey: "userFirstName") as! String)
                }
                
            } catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
// end of userAccountDataControlller
}

struct UserDataDecoded: Claims{
    let id: Int!
    let email: String!
    let firstName: String!
    let lastName: String!
    let hashPassword: String!
    let admin: Int!
    let blocked: Int!
}
struct UserDataObject: Codable{
    let id: Int!
    let email: String!
    let firstName: String!
    let lastName: String!
    let hashPassword: String!
    let admin: Int!
    let blocked: Int!
}

struct UserDataResponse: Codable{
    let authorized: Bool!
    let errorId: Int!
    let jwt: String!
}
