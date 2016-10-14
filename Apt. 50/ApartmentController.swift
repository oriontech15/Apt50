//
//  ApartmentController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class ApartmentController {
    
    static let shared = ApartmentController()
    
    func mockApartments() -> [Apartment] {
        let apartment1 = Apartment(name: "King Henry", website: URL(string: "www.kinghenry.com"))
        let apartment2 = Apartment(name: "The Village", website: URL(string: "www.village.com"))
        let apartment3 = Apartment(name: "Crestwood", website: URL(string: "www.crestwood.com"))
        let apartment4 = Apartment(name: "Stone Ridge", website: URL(string: "www.stoneridge.com"))
        let apartment5 = Apartment(name: "Mountain View", website: URL(string: "www.mountainview.com"))
        let apartment6 = Apartment(name: "Hill Valley", website: URL(string: "www.hillvalley.com"))
        let apartment7 = Apartment(name: "Snickerville", website: URL(string: "www.snickerville.com"))
        let apartment8 = Apartment(name: "Rock Terrace", website: URL(string: "www.rockterrace.com"))
        
        let mocklistings = ["Listing 1", "Listing 2", "Listing 3"]
        
        apartment1.listings = mocklistings
        apartment2.listings = mocklistings
        apartment3.listings = mocklistings
        apartment4.listings = mocklistings
        
        return [apartment1, apartment2, apartment3, apartment4, apartment5, apartment6, apartment7, apartment8]
    }
    
    func apartmentList() -> [String : String] {
        return ["King Henry" : "www.kinghenry.com",
                "The Village" : "www.thevillageatsouthcampus.com",
                "The Branbury" : "www.thebranbury.com",
                "Belmont Apartments" : "www.belmontapts.net"]
    }
}
