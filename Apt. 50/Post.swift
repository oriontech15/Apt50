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
    private let kPhotos = "photos"
    
    var apartmentID: String
    var contactInfoID: String
    var roomType: Int
    var apartmentType: Int
    var tvType: Int
    var internetType: Int
    var laundryType: Int
    var photoURLs: [String]
    
    var endpoint: String {
        return "Posts"
    }
    
    var identifier: String?
    
    var dictionaryCopy: [String : AnyObject] {
        let dictionaryCopy: [String : AnyObject] = [kApartment : apartmentID as AnyObject,
                                                    kContactInfo: contactInfoID as AnyObject,
                                                    kRoomType: roomType as AnyObject,
                                                    kApartmentType : apartmentType as AnyObject,
                                                    kTVType: tvType as AnyObject,
                                                    kInternetType: internetType as AnyObject,
                                                    kLaundryType: laundryType as AnyObject,
                                                    kPhotos : photoURLs as AnyObject]
        
        return dictionaryCopy
    }
    
    init(apartment: String,
         contactInfo: String,
         roomType: RoomType,
         apartmentType: ApartmentType,
         tvType: TVType,
         internetType: InternetType,
         laundryType: LaundryType,
         photoURLs: [String]) {
        
        self.apartmentID = apartment
        self.contactInfoID = contactInfo
        self.roomType = roomType.hashValue
        self.apartmentType = apartmentType.hashValue
        self.tvType = tvType.hashValue
        self.internetType = internetType.hashValue
        self.laundryType = laundryType.hashValue
        self.photoURLs = photoURLs
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        guard let apartmentID = dictionary[kApartment] as? String,
            let contactInfoID = dictionary[kContactInfo] as? String,
            let roomType = dictionary[kRoomType] as? Int,
            let apartmentType = dictionary[kApartmentType] as? Int,
            let tvType = dictionary[kTVType] as? Int,
            let internetType = dictionary[kInternetType] as? Int,
            let laundryType = dictionary[kLaundryType] as? Int,
            let photoURLs = dictionary[kPhotos] as? [String] else { return nil }
        
        self.apartmentID = apartmentID
        self.contactInfoID = contactInfoID
        self.photoURLs = photoURLs
        self.roomType = roomType
        self.apartmentType = apartmentType
        self.tvType = tvType
        self.internetType = internetType
        self.laundryType = laundryType
        self.photoURLs = photoURLs
    }
}
