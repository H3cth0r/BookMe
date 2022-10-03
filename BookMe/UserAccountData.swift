//
//  UserAccountData.swift
//  BookMe
//
//  Created by Héctor Miranda García on 02/10/22.
//

import Foundation
import SwiftJWT
import CommonCrypto.CommonHMAC

enum UserAccountDataError: Error, LocalizedError{
    case itemNotFound
    case decodeError
}


class userAccountDataController{
    let loginURL             =   URL(string: "http://127.0.0.1:5000/app/api/login")!
    let registerURL          =   URL(string: "http://127.0.0.1:5000/app/api/register")!
    let verifyURL            =   URL(string: "http://127.0.0.1:5000/app/api/verifyNewUserData")!
    let changeDataURL        =   URL(string: "http://127.0.0.1:5000/app/api/changeUserData")!
    //let baseURL             =   URL(string: "http://4.228.81.149:5000/app/api/login")!
    //let mailOrUsername      =   "A01659891@tec.mx"
    
    let firstName           =   "Pepo"
    let lastName            =   "Smith"
    let username            =   "elPepe"
    let birthDate           =   "2001/11/23"
    let organization        =   "organization"
    let email                =   "a01354645“tec.mx"
    let ocupation          =   "hacker"
    let countryId           =   12
    let mailOrUsername      =   "pepo117"
    let password            =   "pepo"
    let hashPassword        =   "d50d3319bccca99d3093b689745b168cc79ecfd0e18e3e80be6d8c6ad1061407"
    
    func fetchUserAccountData() async{
        
        //var allOk = true
        
        // request from base URL
        var request         =   URLRequest(url: self.loginURL)
        
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
                
                defaults.set(String(responseTwo.jwt),                   forKey: "userJWT")
                defaults.set(String(jwt.claims.firstName),              forKey: "userFirstName")
                defaults.set(String(jwt.claims.lastName),               forKey: "userLastName")
                defaults.set(String(jwt.claims.email),                  forKey: "userEmail")
                defaults.set(Int(jwt.claims.id ?? 1),                   forKey: "userId")
                defaults.set(String(jwt.claims.hashPassword ?? "sdfsf"),forKey: "userHashPassword")
                defaults.set(Int(   jwt.claims.admin),                  forKey: "userIsAdmin")
                defaults.set(Int(   jwt.claims.blocked),                forKey: "userIsBlocked")
                
                if defaults.object(forKey: "userFirstName") != nil{
                    print(defaults.object(forKey: "userFirstName") as! String)
                    //print(defaults.object(forKey: "userFirstName") as! String)
                }
                
            } catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
    func registerNewUser() async{
        let str = self.password
        let dat = ccSha256(data: str.data(using: .utf8)!)
        let hp = dat.map { String(format: "%02hhx", $0) }.joined()
        //print("sha256 String: \(data.map { String(format: "%02hhx", $0) }.joined())")
        //print(hp == self.hashPassword)
        var request     =   URLRequest(url: self.registerURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "firstName"      :  self.firstName,
            "lastName"       :  self.lastName,
            "username"       :  self.username,
            "birthDate"      :  self.birthDate,
            "organization"   :  self.organization,
            "email"          :  self.email,
            "ocupation"      :  self.ocupation,
            "countryId"      :  self.countryId,
            "hashPassword"   :  hp
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(UserDataRegistrationResponse.self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
        
        
    }
    
    func getVerification() async{
        var request     =       URLRequest(url: self.verifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaults = UserDefaults.standard
        print(String(defaults.object(forKey: "userJWT") as! String))
        let body: [String: AnyHashable] = [
            "jwt"           : String(defaults.object(forKey: "userJWT") as! String),
            "username"      : "pepo117",
            "email"         : "A01659891@tec.mx"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(UserDataVerificationResponse.self, from: data)
                print(response)
            } catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func saveNewData() async{
        var request         =       URLRequest(url: self.changeDataURL)
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaults    =   UserDefaults.standard
        let body: [String: AnyHashable] = [
            "jwt"               :   String(defaults.object(forKey: "userJWT") as! String),
            "oldHashPassword"   :   self.hashPassword,
            "firstName"         :   "Pepo",
            "lastName"          :   "Smith",
            "username"          :   "pepo117",
            "birthDate"         :   "2002-11-11 11:11:11.111",
            "organization"      :   "Tec",
            "email"             :   "A01659891@tec.mx",
            "hashPassword"      :   self.hashPassword
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // make request
        let task            =   URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
               let response = try JSONDecoder().decode(UserDataChangedResponse.self, from: data)
                print(response)
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


struct UserDataResponse: Codable{
    let authorized: Bool!
    let errorId: Int!
    let jwt: String!
}

struct UserDataRegistrationResponse: Codable{
    let readyToVerify: Bool!
    let errorId: Int!
}

struct UserDataVerificationResponse: Codable{
    let available: Bool!
    let errorIds: [Int]!
}

struct UserDataChangedResponse: Codable{
    let saved   : Bool!
}

func ccSha256(data: Data) -> Data {
    var digest = Data(count: Int(CC_SHA256_DIGEST_LENGTH))

    _ = digest.withUnsafeMutableBytes { (digestBytes) in
        data.withUnsafeBytes { (stringBytes) in
            CC_SHA256(stringBytes, CC_LONG(data.count), digestBytes)
        }
    }
    return digest
}
