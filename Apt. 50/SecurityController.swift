//
//  SecurityController.swift
//  Apt. 50
//
//  Created by Justin Smith on 12/15/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class SecurityController {
    
    static let shared = SecurityController()
    
    let auth = FIRAuth.auth()
    
    private func checkErrors(error: Error?) -> (errorMessage: String, errorCode: String)? {
        if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
            switch errCode {
            case .errorCodeEmailAlreadyInUse:
                return (errorMessage: "Email already in use. Please use another email.", errorCode: "\(FIRAuthErrorCode.errorCodeEmailAlreadyInUse.rawValue)")
            case .errorCodeInvalidEmail:
                return (errorMessage: "Invalid Email. Please check your spelling and try again.", errorCode: "\(FIRAuthErrorCode.errorCodeInvalidEmail.rawValue)")
            case .errorCodeWrongPassword:
                return (errorMessage: "Invalid Password. Please try again.", errorCode: "\(FIRAuthErrorCode.errorCodeWrongPassword.rawValue)")
            case .errorCodeNetworkError:
                return (errorMessage: "Network error. Could not connect. Please try again later.", errorCode: "\(FIRAuthErrorCode.errorCodeNetworkError.rawValue)")
            case .errorCodeInternalError:
                return (errorMessage: "Internal Error.", errorCode: "\(FIRAuthErrorCode.errorCodeInternalError.rawValue)")
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    
    func signInGoogle(crediential: FIRAuthCredential, userID: String, completion: @escaping (_ user: User?, _ error: (errorMessage: String, errorCode: String)?) -> Void) {
        
        FIRAuth.auth()?.signIn(with: crediential, completion: { (googleUser, error) in
            if let error = error {
                print(error.localizedDescription)
                
                if let errorCode = self.checkErrors(error: error) {
                    completion( nil, errorCode)
                } else {
                    completion( nil, ("Unknown Error. Please try again.", "[-]"))
                }
            } else {
                
                if let googleUser = googleUser {
                    print("NAME: --- \(googleUser.displayName)")
                    print("EMAIL: --- \(googleUser.email)")
                    print("USER ID: --- \(googleUser.uid)")
                    
                    if let name = googleUser.displayName, let email = googleUser.email {
                        
                        UserController.shared.getUserFor(userID, completion: { (user) in
                            if let user = user {
                                UserController.shared.user = user
                                completion(user, nil)
                            } else {
                                UserController.shared.createGoogleUser(name: name, userID: userID, email: email, phone: "", completion: { (user) in
                                    UserController.shared.user = user
                                    completion(user, nil)
                                })
                            }
                        })
                    }
                }
            }
        })
    }
    
    //xMDXnrKk_OqqFBR7g
    
    func signInFacebook(crediential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: crediential, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
            
            if let user = user {
                print("NAME: --- \(user.displayName)")
                print("EMAIL: --- \(user.email)")
                print("USER ID: --- \(user.uid)")
            }
        })
    }
    
    func signInGeneral(email: String, password: String, completion: @escaping (_ user: User?, _ error: (errorMessage: String, errorCode: String)?) -> Void) {
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                if let errorCode = self.checkErrors(error: error) {
                    completion(nil, errorCode)
                } else {
                    completion(nil, ("Unknown Error. Please try again.", "[-]"))
                }
            } else {
                
                if let user = user {
                    print("NAME: --- \(user.displayName)")
                    print("EMAIL: --- \(user.email)")
                    print("USER ID: --- \(user.uid)")
                    
                    UserController.shared.getUserFor(user.uid, completion: { (user) in
                        if let user = user {
                            UserController.shared.user = user
                            completion(user, nil)
                        } else {
                            completion(user, (errorMessage: "Could not find user.", errorCode: "User ERROR"))
                        }
                    })
                }
            }
        })
    }
    
    func signUp(name: String, email: String, password: String, phone: String, completion: @escaping (_ user: User?, _ error: (errorMessage: String, errorCode: String)?) -> Void) {
        
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                if let errorCode = self.checkErrors(error: error) {
                    completion(nil, errorCode)
                } else {
                    completion(nil, ("Unknown Error. Please try again.", "[-]"))
                }
            } else {
                if let user = user {
                    UserController.shared.createUser(name: name, userID: user.uid, email: email, phone: phone, completion: { (user) in
                        UserController.shared.user = user
                        completion(user, nil)
                    })
                }
            }
        })
    }
    
    func encryptString(_ string: String) -> String {
        
        var encryptedString: String = ""
        for character in string.characters {
            encryptedString = encryptedString + character.encrypted
        }
        
        return encryptedString
    }
    
    func decryptString(_ string: String) -> String {
        
        var decryptedString: String = ""
        
        var lastIndex: String.Index = string.startIndex
        for index in 0...string.characters.count {
            
            if index % 3 == 0 && index > 0 {
                let toIndex = string.index(string.startIndex, offsetBy: index)
                let characters = string[Range(lastIndex ..< toIndex)]
                
                decryptedString = decryptedString + "\(characters.decrypted)"
                lastIndex = toIndex
            }
        }
        
        return decryptedString
    }
}
