//
//  Apartment.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class Apartment: FirebaseType {
    
    private let kName = "name"
    private let kWebsite = "website"
    private let kListings = "listings"
    
    var endpoint: String {
        return "Apartments"
    }
    
    var identifier: String?
    let name: String
    var website: URL?
    var listings: [String]? // Will be an array of Posts
    
    var dictionaryCopy: [String : AnyObject] {
        var dictionaryCopy = [kName : name as AnyObject]
        
        guard let website = self.website else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(website as AnyObject, forKey: kWebsite)
        
        guard let listings = self.listings else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(listings as AnyObject, forKey: kListings)

        
        return dictionaryCopy
    }
    
    init(name: String, website: URL?) {
        self.name = name
        self.website = website
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let name = dictionary[kName] as? String,
            let websiteString = dictionary[kWebsite] as? String,
            let listings = dictionary[kListings] as? [String] else { return nil }
        
        self.name = name
        self.listings = listings

        if let url = URL(string: websiteString) {
            self.website = url
        }
        
    }
}
