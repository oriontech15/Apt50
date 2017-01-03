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
    private let kApartmentID = "apartmentID"
    
    var endpoint: String {
        return "Apartments"
    }
    
    var identifier: String?

    let name: Apartments
    var website: String?
    var listings: [String] = []
    
    var apartmentID: String {
        get {
            return name.identifier
        }
    }
    
    var dictionaryCopy: [String : AnyObject] {
        var dictionaryCopy = [kName : name.rawValue as AnyObject]
        
        guard let website = self.website else {
            return dictionaryCopy
        }
        
        dictionaryCopy.updateValue(website as AnyObject, forKey: kWebsite)
        dictionaryCopy.updateValue(listings as AnyObject, forKey: kListings)
        dictionaryCopy.updateValue(apartmentID as AnyObject, forKey: kApartmentID)
        
        return dictionaryCopy
    }
    
    init(name: Apartments, website: String, apartmentID: String) {
        self.name = name
        self.website = website
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let name = dictionary[kName] as? String,
            let websiteString = dictionary[kWebsite] as? String else { return nil }
        
        self.name = Apartments(rawValue: name)!
        self.website = websiteString
        self.identifier = identifier
        
        print(self.identifier!)
        guard let listings = dictionary[kListings] as? [String] else { return }
        self.listings = listings
    }
}
