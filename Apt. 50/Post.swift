//
//  Post.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class Post: FirebaseType {
    
    private let kApartment = "apartment"
    private let kContactInfo = "contactInfo"
    private let kRoomType = "roomType"
    private let kApartmentType = "apartmentType"
    private let kTVType = "tvType"
    private let kInternetType = "internetType"
    private let kLaundryType = "laundryType"
    private let kParkingType = "parkingType"
    private let kPhotos = "photos"
    private let kRent = "rentPrice"
    
    var apartment: Apartment?
    var apartmentID: String = ""
    var contactInfo: ContactInfo?
    var contactInfoID: String = ""
    var roomType: String
    var apartmentType: String
    var tvType: String
    var internetType: String
    var laundryType: String
    var parkingType: String
    var rentPrice: Double
    var photoURLs: [String : String]?
    var photos: [UIImage] = []
    
    var endpoint: String {
        return "Posts"
    }
    
    var identifier: String?
    
    var dictionaryCopy: [String : AnyObject] {
        let rent = NSNumber(value: rentPrice)
        let dictionaryCopy: [String : AnyObject] = [kApartment : apartmentID as AnyObject,
                                                    kContactInfo: contactInfoID as AnyObject,
                                                    kRoomType: roomType as AnyObject,
                                                    kApartmentType : apartmentType as AnyObject,
                                                    kTVType: tvType as AnyObject,
                                                    kInternetType: internetType as AnyObject,
                                                    kLaundryType: laundryType as AnyObject,
                                                    kParkingType: parkingType as AnyObject,
                                                    kRent : rent as AnyObject,
                                                    kPhotos : photoURLs as AnyObject]
        
        return dictionaryCopy
    }
    
    init(apartment: Apartment,
         contactInfo: ContactInfo?,
         roomType: String,
         apartmentType: String,
         tvType: String,
         internetType: String,
         laundryType: String,
         parkingType: String,
         rentPrice: Double,
         photoURLs: [String : String]) {
        
        self.apartment = apartment
        
        self.contactInfo = contactInfo
        self.roomType = roomType
        self.apartmentType = apartmentType
        self.tvType = tvType
        self.internetType = internetType
        self.laundryType = laundryType
        self.photoURLs = photoURLs
        self.parkingType = parkingType
        self.rentPrice = rentPrice
        
        if let apartmentID = apartment.identifier {
            self.apartmentID = apartmentID
        }
        
        if let contactInfoID = contactInfo?.identifier {
            self.contactInfoID = contactInfoID
        }
    }
    
    convenience init() {
        let roomType = RoomType.privateRoom.rawValue
        let apartmentType = ApartmentType.male.rawValue
        let tvType = TVType.notIncluded.rawValue
        let internetType = InternetType.notIncluded.rawValue
        let laundryType = LaundryType.apartment.rawValue
        let parkingType = ParkingType.notIncluded.rawValue
        let rentPrice = 0.0
        let apartment = Apartment(name: Apartments.kingHenry, website: Apartments.kingHenry.website, apartmentID: Apartments.kingHenry.identifier)
        self.init(apartment: apartment,
                  contactInfo: nil,
                  roomType: roomType,
                  apartmentType: apartmentType,
                  tvType: tvType,
                  internetType: internetType,
                  laundryType: laundryType,
                  parkingType: parkingType,
                  rentPrice: rentPrice,
                  photoURLs: [:])
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let apartmentID = dictionary[kApartment] as? String,
            let contactInfoID = dictionary[kContactInfo] as? String,
            let roomType = dictionary[kRoomType] as? String,
            let apartmentType = dictionary[kApartmentType] as? String,
            let tvType = dictionary[kTVType] as? String,
            let internetType = dictionary[kInternetType] as? String,
            let laundryType = dictionary[kLaundryType] as? String,
            let parkingType = dictionary[kParkingType] as? String,
            let rentPrice = dictionary[kRent] as? NSNumber,
            let photoURLs = dictionary[kPhotos] as? [String : String] else { return nil }
        
        self.identifier = identifier
        self.apartmentID = apartmentID
        self.contactInfoID = contactInfoID
        self.roomType = roomType
        self.apartmentType = apartmentType
        self.tvType = tvType
        self.internetType = internetType
        self.laundryType = laundryType
        self.parkingType = parkingType
        self.rentPrice = rentPrice.doubleValue
        self.photoURLs = photoURLs
    }
}
