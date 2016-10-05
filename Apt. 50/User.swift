//
//  User.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let contactInfo: ContactInfo
    let posts: [Post]?
    let bookmarks: [Post]?
    
    init(name: String, contactInfo: ContactInfo) {
        self.name = name
        self.contactInfo = contactInfo
        self.posts = nil
        self.bookmarks = nil
    }
}
