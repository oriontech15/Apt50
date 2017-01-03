//
//  User.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class User: FirebaseType {
    
    private let kName = "name"
    private let kContactInfoID = "contactInfoID"
    private let kPosts = "posts"
    private let kBookmarks = "bookmarks"
    private let kProfileImage = "profileImage"
    
    let name: String
    let contactInfoID: String
    var contactInfo: ContactInfo?
    var posts: [String]?
    var bookmarks: [String]?
    var profileImageURL: [String : String]?
    var profileImage: UIImage?
    
    var endpoint: String {
        return "Users"
    }
    
    var identifier: String?
    
    var dictionaryCopy: [String : AnyObject] {
        
        var dictionaryCopy = [kName : name as AnyObject,
                              kContactInfoID : contactInfoID as AnyObject]
        
        guard let profileImage = profileImageURL else { return dictionaryCopy }
        
        dictionaryCopy.updateValue(profileImage as AnyObject, forKey: kProfileImage)
        
        guard let posts = posts else { return dictionaryCopy }
        
        dictionaryCopy.updateValue(posts as AnyObject, forKey: kPosts)

        guard let bookmarks = bookmarks else { return dictionaryCopy }
        
        dictionaryCopy.updateValue(bookmarks as AnyObject, forKey: kBookmarks)
        
        return dictionaryCopy
    }
    
    init(name: String, contactInfoID: String) {
        self.name = name
        self.contactInfoID = contactInfoID
        self.posts = []
        self.bookmarks = []
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        print(dictionary)
        guard let name = dictionary[kName] as? String , let contactInfoID = dictionary[kContactInfoID] as? String else { return nil }
        
        self.name = name
        self.contactInfoID = contactInfoID
        self.identifier = identifier
        
        if let posts = dictionary[kPosts] as? [String] {
            self.posts = posts
        }
            
        if let bookmarks = dictionary[kBookmarks] as? [String] {
            self.bookmarks = bookmarks
        }
        
        if let profileImageURL = dictionary[kProfileImage] as? [String : String] {
            self.profileImageURL = profileImageURL
        }
    }
}
