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
    
    var firstName           :   String!
    var lastName            :   String!
    var username            :   String!
    var birthDate           :   String!
    var organization        :   String!
    var email               :   String!
    var userId              :   String!
    var ocupation           :   String!
    var countryId           :   Int!
    var mailOrUsername      :   String!
    var password            :   String!
    var hashPassword        :   String!
    
    func setSavedValues(){
        /*
         defaults.set(String(responseTwo.jwt),                   forKey: "userJWT")
         defaults.set(String(jwt.claims.firstName),              forKey: "userFirstName")
         defaults.set(String(jwt.claims.lastName),               forKey: "userLastName")
         defaults.set(String(jwt.claims.email),                  forKey: "userEmail")
         defaults.set(Int(jwt.claims.id ?? 1),                   forKey: "userId")
         defaults.set(String(jwt.claims.hashPassword ?? "sdfsf"),forKey: "userHashPassword")
         defaults.set(Int(   jwt.claims.admin),                  forKey: "userIsAdmin")
         defaults.set(Int(   jwt.claims.blocked),                forKey: "userIsBlocked")
         */
        let defaults = UserDefaults.standard
        self.firstName          =   defaults.object(forKey: "userFirstName")        as? String
        self.lastName           =   defaults.object(forKey: "userLastName")         as? String
        self.username           =   defaults.object(forKey: "userUsername")         as? String
        self.birthDate          =   defaults.object(forKey: "userBirthDay")         as? String
        self.organization       =   defaults.object(forKey: "userOrganization")     as? String
        self.email              =   defaults.object(forKey: "userEmail")            as? String
        self.userId             =   defaults.object(forKey: "userId")               as? String
        self.hashPassword       =   defaults.object(forKey: "hashPassword")         as? String
    }
    
    
    /*
     *  @brief
     *  This method will only get the jwt of the user and a boolean if athorized.
     *  Then if the authorized == true, it will get redirected to verification view.
     */
    
    func loginWithCredentials(username_t: String, hashPassword_t: String, completion: @escaping (Bool)->Void) async{
        // request from base URL
        var request         =   URLRequest(url: self.loginURL)
        
        // Method body headers
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "username"      : username_t,
            "password"      : hashPassword_t
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
                completion(responseTwo.authorized)
                
            } catch{
                print(error)
                completion(false)
            }
        }
        task.resume()
    }
    
    
    /*
     *  @brief
     *  This method will get the user data when it gets to the main view.
     */
    func fetchUserAccountData(username_t: String, hashPassword_t: String, completion: @escaping (Bool)->Void) async{
        // request from base URL
        var request         =   URLRequest(url: self.loginURL)
        
        // Method body headers
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "username"      : username_t,
            "password"      : hashPassword_t
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
                print(responseTwo)
                
                let jwtVerifier = JWTVerifier.hs256(key: Data("BooKMeIsCool".utf8))
                let jwtDecoder = JWTDecoder(jwtVerifier: jwtVerifier)
                let jwt = try jwtDecoder.decode(JWT<UserDataDecoded>.self, fromString: responseTwo.jwt)

                // save claims to defaults(jwt)
                let defaults = UserDefaults.standard
                
                // set data to defaults
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
                }
                completion(true)
                
            } catch{
                print(error)
                completion(false)
            }
        }
        task.resume()
        
    }
    
    func registerNewUser(firstName_t: String, lastName_t: String, username_t: String, birthDate_t: String, organization_t: String, mail_t: String, ocupation_t: String, countryId_t: String, password_t: String, completion: @escaping (Bool)->Void) async{
        let str = password_t
        let dat = ccSha256(data: str.data(using: .utf8)!)
        let hp: String = dat.map{ String(format: "%02hhx", $0) }.joined()

        var request     =   URLRequest(url: self.registerURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "firstName"      :  firstName_t,
            "lastName"       :  lastName_t,
            "username"       :  username_t,
            "birthDate"      :  birthDate_t,
            "organization"   :  organization_t,
            "email"          :  mail_t,
            "ocupation"      :  ocupation_t,
            "countryId"      :  1,
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
                completion(response.readyToVerify)
            } catch{
                print(error)
                completion(false)
            }
        }
        task.resume()
    }
    
    func getVerification(username_t: String, email_t: String) async{
        var request     =       URLRequest(url: self.verifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaults = UserDefaults.standard
        print(String(defaults.object(forKey: "userJWT") as! String))
        let body: [String: AnyHashable] = [
            "jwt"           : String(defaults.object(forKey: "userJWT") as! String),
            "username"      : username_t,
            "email"         : email_t
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
    
    func saveNewData(jwt_t: String, oldHashPassword_t: String, firstName_t: String, lastName_t: String, username_t: String, birthDate_t: String, organization_t: String, email_t: String, hashPassword_t: String) async{
        var request         =       URLRequest(url: self.changeDataURL)
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaults    =   UserDefaults.standard
        let body: [String: AnyHashable] = [
            "jwt"               :   String(defaults.object(forKey: "userJWT") as! String),
            "oldHashPassword"   :   oldHashPassword_t,
            "firstName"         :   firstName_t,
            "lastName"          :   lastName_t,
            "username"          :   username_t,
            "birthDate"         :   birthDate_t,
            "organization"      :   organization_t,
            "email"             :   email_t,
            "hashPassword"      :   hashPassword_t
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
    //let username: String!
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
