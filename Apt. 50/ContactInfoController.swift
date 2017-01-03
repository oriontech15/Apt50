//
//  ContactInfoController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ContactInfoController {
    
    static let shared = ContactInfoController()
    
    func mockContacts() -> [ContactInfo] {
        let contact1 = ContactInfo(contactName: "Susan Beets", phoneNumber: "8015463338")
        let contact2 = ContactInfo(contactName: "Durk Snitzle", phoneNumber: "8014443522")
        let contact3 = ContactInfo(contactName: "Nelson Jones", phoneNumber: "8016678451")
        
        return [contact1, contact2, contact3]
    }
    
    func getContactInfo() -> ContactInfo {
        let contact = ContactInfo(contactName: "Justin Smith", phoneNumber: "8014443522")
        return contact
    }
    
    func createContactInfo(name: String, email: String, phone: String, completion: @escaping (_ contactInfo: ContactInfo?) -> Void) {
        
        let phoneEncrypted = SecurityController.shared.encryptString(phone)
        let emailEncrypted = SecurityController.shared.encryptString(email)
        let nameEncrypted = SecurityController.shared.encryptString(name)
        
        var contactInfo = ContactInfo(contactName: nameEncrypted, phoneNumber: phoneEncrypted, email: emailEncrypted)
        
        contactInfo.save()
        
        
        contactInfo.contactName = SecurityController.shared.decryptString(nameEncrypted)
        contactInfo.phoneNumber = SecurityController.shared.decryptString(phoneEncrypted)
        contactInfo.email = SecurityController.shared.decryptString(emailEncrypted)
        
        completion(contactInfo)
    }
    
    func getContactInfoForUser(user: User, contactInfoID: String, completion: @escaping (_ contactInfo: ContactInfo?) -> Void) {
        FirebaseController.ref.child("ContactInfo").child(user.contactInfoID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let contactInfoDict = snapshot.value as? [String : AnyObject] else {
                completion(nil)
                return
            }
            
            let contactInfo = ContactInfo(dictionary: contactInfoDict, identifier: user.contactInfoID)
            
            if let name = contactInfo?.contactName {
                contactInfo?.contactName = SecurityController.shared.decryptString(name)
            }
            
            if let phone = contactInfo?.phoneNumber {
                contactInfo?.phoneNumber = SecurityController.shared.decryptString(phone)
            }
            
            if let email = contactInfo?.email {
                contactInfo?.email = SecurityController.shared.decryptString(email)
            }
            
            completion(contactInfo)
        })
    }
    
    func updateContactInfo(forUser user: User, name: String, email: String, phone: String, completion: @escaping (_ contactInfo: ContactInfo?) -> Void) {
        let phoneEncrypted = SecurityController.shared.encryptString(phone)
        let emailEncrypted = SecurityController.shared.encryptString(email)
        let nameEncrypted = SecurityController.shared.encryptString(name)
        
        if var contactInfo = user.contactInfo {
            contactInfo.email = emailEncrypted
            contactInfo.contactName = nameEncrypted
            contactInfo.phoneNumber = phoneEncrypted
            
            contactInfo.save()
            completion(contactInfo)
        }
    }
}
