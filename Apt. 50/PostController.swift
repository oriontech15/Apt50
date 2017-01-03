//
//  PostController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static let shared = PostController()
    
    var tempPost: Post?
    
    var selectedPhotoKey: PhotoType = .none
    
    var tempPhotos: [PhotoType : UIImage] = [:]
    
    init() {}
    
    func createPost(apartment: Apartment,
                    contactInfo: ContactInfo,
                    roomType: String,
                    apartmentType: String,
                    tvType: String,
                    internetType: String,
                    laundryType: String,
                    parkingType: String,
                    rentPrice: Double,
                    photos: [String : UIImage], completion: @escaping (_ success: Bool) -> Void) {
        
        var images: [UIImage] = []
        for (_, photo) in photos {
            if let resizedPhoto = photo.resizeImage(size: CGSize(width: UIScreen.main.bounds.width + 80, height: 200)) {
                images.append(resizedPhoto)
            }
        }
        
        ImageController.shared.saveImages(images: images, completion: { (urlStrings) in
            
            if let urlStrings = urlStrings {
                var post = Post(apartment: apartment,
                                contactInfo: contactInfo,
                                roomType: roomType,
                                apartmentType: apartmentType,
                                tvType: tvType,
                                internetType: internetType,
                                laundryType: laundryType,
                                parkingType: parkingType,
                                rentPrice: rentPrice,
                                photoURLs: urlStrings)
                
                
                post.save()
                
                if let apartment = post.apartment, let identifier = post.identifier {
                    ApartmentController.shared.addPost(toApartment: apartment, postID: identifier)
                }
                
                completion(true)
            }
        })
    }
    
    func getPosts(forUser user: User) -> Post? {
        
        return nil
    }
    
    func getPosts(forApartment apartment: Apartment, completion: @escaping (_ post: [Post]?) -> Void) {
        if let identifier = apartment.identifier {
            FirebaseController.ref.child(apartment.endpoint).child(identifier).child("listings").observeSingleEvent(of: .value, with: { (snapshot) in
                let postIDs = snapshot.value as? [String] ?? []
                print(postIDs)
                var posts: [Post] = []
                
                let group = DispatchGroup()
                let queue = DispatchQueue(label: "getPosts")
                for postID in postIDs {
                    group.enter()
                    queue.async {
                        
                        print("ENTER")
                        self.getPost(forPostID: postID, apartment: apartment, completion: { (post) in
                            if let post = post {
                                posts.append(post)
                                group.leave()
                                print("LEFT")
                            }
                        })
                    }
                }
                group.notify(queue: queue, execute: {
                    print(posts)
                    completion(posts)
                })
            })
        }
    }
    
    func getPost(forPostID id: String?, apartment: Apartment, completion: @escaping (_ post: Post?) -> Void) {
        if let identifier = id {
            FirebaseController.ref.child("Posts").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                if let post = Post(dictionary: postDict, identifier: identifier) {
                    post.apartment = apartment
                    completion(post)
                }
            })
        }
    }
}
