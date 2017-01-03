//
//  UserController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn

class UserController {
    
    static let shared = UserController()
    
    var tempProfilePhoto: [String : UIImage] = [:]
    
    var user: User! {
        didSet {
            print("USER SET")
        }
    }
    
    func createUser(name: String, userID: String, email: String, phone: String, completion: @escaping(_ user: User?) -> Void) {
        
        ContactInfoController.shared.createContactInfo(name: name, email: email, phone: phone) { (contactInfo) in
            if let contactInfo = contactInfo, let infoID = contactInfo.identifier {
                var user = User(name: name, contactInfoID: infoID)
                user.save()
                completion(user)
            }
        }
    }
    
    func createGoogleUser(name: String, userID: String, email: String, phone: String, completion: @escaping(_ user: User?) -> Void) {
        
        ContactInfoController.shared.createContactInfo(name: name, email: email, phone: phone) { (contactInfo) in
            if let contactInfo = contactInfo, let infoID = contactInfo.identifier {
                var user = User(name: name, contactInfoID: infoID)
                user.identifier = userID
                user.contactInfo = contactInfo
                user.save()
                completion(user)
            }
        }
    }
    
    func getUserFor(_ uid: String, completion: @escaping (_ user: User?) -> Void) {
        FirebaseController.ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDict = snapshot.value as? [String : AnyObject] else {
                completion(nil)
                return
            }
            
            if let user = User(dictionary: userDict, identifier: uid) {
                if let imageURL = user.profileImageURL, let key = imageURL.keys.first, let value = imageURL[key] {
                    
                    ImageController.shared.imageForUrl(urlString: value, completion: { (image) in
                        user.profileImage = image
                    })
                }
                
                ContactInfoController.shared.getContactInfoForUser(user: user, contactInfoID: user.contactInfoID, completion: { (contactInfo) in
                    user.contactInfo = contactInfo
                    completion(user)
                })
            }
        })
    }
    
    func getProfileImage(completion: @escaping (_ image: UIImage?) -> Void) {
        
        if let imageID = user.profileImageURL?.keys.first, let url = user.profileImageURL?[imageID] {
            ImageController.shared.imageForUrl(urlString: url, completion: { (image) in
                if let image = image {
                    completion(image)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    func updateProfileImage(image: UIImage, completion: @escaping (_ success: Bool) -> Void) {
        if let image = user.profileImageURL, let key = image.keys.first {
            ImageController.shared.deleteImage(forUrl: key)
        }
        
        ImageController.shared.saveProfileImage(image: image) { (urlDictionary) in
            var user = UserController.shared.user!
            user.profileImageURL = urlDictionary
            user.save()
            completion(true)
        }
    }
}
