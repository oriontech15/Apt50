//
//  ImageController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

let uploadingImageNotification = Notification.Name("uploadingImage")
let uploadedImageNotification = Notification.Name("uploadedImage")

protocol ProgressDelegate {
    func changeLabelUpdated()
    func changeLabelUpdating()
}

class ImageController {
    static let shared = ImageController()
    
    var storageRef = FIRStorageReference()
    
    var progressDelegate: ProgressDelegate?
    
    init() {
        configureStorage()
    }
    
    func configureStorage() {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    
    func saveProfileImage(image: UIImage, completion: @escaping (_ imageURLs: [String : String]?) -> Void){
        
        var imageURLs: [String : String] = [:]
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "postingProfileImage")
        
        if let uploadData = UIImagePNGRepresentation(image) {
            let imageName = NSUUID().uuidString
            
            group.enter()
            queue.async {
                self.progressDelegate?.changeLabelUpdating()
                self.storageRef.child("Profile Pictures").child(imageName).put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(nil)
                    } else {
                        let value = metadata?.downloadURL()?.absoluteString
                        imageURLs.updateValue(value!, forKey: imageName)
                        self.progressDelegate?.changeLabelUpdated()
                        group.leave()
                    }
                })
            }
        }
        
        group.notify(queue: queue, execute: {
            completion(imageURLs)
        })
    }
    
    func saveImages(images: [UIImage], completion: @escaping (_ imageURLs: [String : String]?) -> Void){
        
        var imageURLs: [String : String] = [:]
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "postingImages")
        
        for (_, image) in images.enumerated() {
            if let uploadData = UIImagePNGRepresentation(image) {
                let imageName = NSUUID().uuidString
                
                group.enter()
                queue.async {
                    self.progressDelegate?.changeLabelUpdating()
                    self.storageRef.child("Apartment Screenshots").child(imageName).put(uploadData, metadata: nil, completion: { (metadata, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(nil)
                        } else {
                            let value = metadata?.downloadURL()?.absoluteString
                            imageURLs.updateValue(value!, forKey: imageName)
                            self.progressDelegate?.changeLabelUpdated()
                            group.leave()
                        }
                    })
                }
            }
        }
        
        group.notify(queue: queue, execute: {
            if imageURLs.count == images.count {
                completion(imageURLs)
            }
        })
    }
    
    func deleteImage(forUrl imageID: String) -> Void {
        storageRef.child("Apartment Screenshots").child(imageID).delete { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func imageForUrl(urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            fatalError("Image URL optional is nil")
        }
        
        NetworkController.performRequestForURL(url: url, httpMethod: .get) { (data, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
    }
}
