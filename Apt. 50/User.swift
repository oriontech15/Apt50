//
//  User.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class User: FirebaseType {
    
    private let kName = "name"
    private let kContactInfoID = "contactInfoID"
    private let kPosts = "posts"
    private let kBookmarks = "bookmarks"
    
    let name: String
    let contactInfoID: String
    let posts: [String]?
    let bookmarks: [String]?
    
    var endpoint: String {
        return "Users"
    }
    
    var identifier: String?
    
    var dictionaryCopy: [String : AnyObject] {
        
        var dictionaryCopy = [kName : name as AnyObject,
                              kContactInfoID : contactInfoID as AnyObject]
        
        guard let posts = self.posts else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(posts as AnyObject, forKey: kPosts)

        guard let bookmarks = self.bookmarks else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(bookmarks as AnyObject, forKey: kBookmarks)

        return dictionaryCopy
    }
    
    init(name: String, contactInfoID: String) {
        self.name = name
        self.contactInfoID = contactInfoID
        self.posts = nil
        self.bookmarks = nil
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let name = dictionary[kName] as? String , let contactInfoID = dictionary[kContactInfoID] as? String, let posts = dictionary[kPosts] as? [String], let bookmarks = dictionary[kBookmarks] as? [String] else { return nil }
        
        self.name = name
        self.contactInfoID = contactInfoID
        self.posts = posts
        self.bookmarks = bookmarks
    }
}
