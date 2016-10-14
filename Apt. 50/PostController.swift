//
//  PostController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    
    func mockPosts() -> [Post] {
        
        let apartments = ApartmentController.shared.mockApartments()
        let contacts = ContactInfoController.shared.mockContacts()
        
        let post1 = Post(apartment: apartments[0], contactInfo: contacts[1], roomType: .privateRoom, apartmentType: .male, tvType: .included, internetType: .included, laundryType: .shared, photoURLs: [])
        
        let post2 = Post(apartment: apartments[0], contactInfo: contacts[0], roomType: .sharedRoom, apartmentType: .married, tvType: .notIncluded, internetType: .included, laundryType: .inRoom, photoURLs: [])
        
        let post3 = Post(apartment: apartments[0], contactInfo: contacts[2], roomType: .privateRoom, apartmentType: .male, tvType: .notIncluded, internetType: .included, laundryType: .inRoom, photoURLs: [])
        
        let post4 = Post(apartment: apartments[0], contactInfo: contacts[1], roomType: .sharedRoom, apartmentType: .female, tvType: .included, internetType: .notIncluded, laundryType: .shared, photoURLs: [])
        
        return [post1, post2, post3, post4]
    }
    
    func getPostsForApartment(apartment: Apartment) -> [Post]? {
        
        var filteredPosts: [Post] = []
        for post in mockPosts() {
            if post.apartment.name == apartment.name {
                filteredPosts.append(post)
            }
        }
        
        return filteredPosts
    }
    
}
