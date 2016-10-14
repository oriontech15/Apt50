//
//  ContactInfoController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class ContactInfoController {
    
    static let shared = ContactInfoController()
    
    func mockContacts() -> [ContactInfo] {
        let contact1 = ContactInfo(contactName: "Susan Beets", phoneNumber: "8015463338")
        let contact2 = ContactInfo(contactName: "Durk Snitzle", phoneNumber: "8014443522")
        let contact3 = ContactInfo(contactName: "Nelson Jones", phoneNumber: "8016678451")
        
        return [contact1, contact2, contact3]
    }
}
