//
//  Apartment.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class Apartment {
    let name: String
    let website: NSURL?
    
    init(name: String, website: NSURL?) {
        self.name = name
        self.website = website
    }
}
