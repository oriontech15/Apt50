//
//  ContactInfo.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class ContactInfo {
    let contactName: String
    let phoneNumber: String
    let email: String?
    
    init(contactName: String, phoneNumber: String, email: String? = "") {
        self.contactName = contactName
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
