//
//  ContactInfo.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class ContactInfo: FirebaseType {
    
    private let kContactName = "contactName"
    private let kPhoneNumber = "phoneNumber"
    private let kEmail = "email"
    
    var endpoint: String {
        return "ContactInfo"
    }
    
    var identifier: String?
    var contactName: String
    var phoneNumber: String
    var email: String?
    
    var dictionaryCopy: [String : AnyObject] {
        
        var dictionaryCopy = [kContactName : contactName as AnyObject, kPhoneNumber : phoneNumber as AnyObject]
        
        guard let email = self.email else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(email as AnyObject, forKey: kEmail)
        
        return dictionaryCopy
    }
    
    init(contactName: String, phoneNumber: String, email: String? = "") {
        //self.identifier = UserController.shared.currentUser.uid
        self.contactName = contactName
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let contactName = dictionary[kContactName] as? String,
            let phoneNumber = dictionary[kPhoneNumber] as? String else { return nil }
        
        self.contactName = contactName
        self.phoneNumber = phoneNumber
        self.identifier = identifier
        
        if let email = dictionary[kEmail] as? String {
            self.email = email
        }
    }
}
