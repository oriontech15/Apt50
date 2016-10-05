//
//  Post.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let apartment: Apartment
    let contactInfo: ContactInfo
    let roomType: RoomType
    let apartmentType: ApartmentType
    let tvType: TVType
    let internetType: InternetType
    let laundryType: LaundryType
    let photoURLs: [String]
    
    init(apartment: Apartment,
         contactInfo: ContactInfo,
         roomType: RoomType,
         apartmentType: ApartmentType,
         tvType: TVType,
         internetType: InternetType,
         laundryType: LaundryType,
         photoURLs: [String]) {
        self.apartment = apartment
        self.contactInfo = contactInfo
        self.roomType = roomType
        self.apartmentType = apartmentType
        self.tvType = tvType
        self.internetType = internetType
        self.laundryType = laundryType
        self.photoURLs = photoURLs
    }
}
