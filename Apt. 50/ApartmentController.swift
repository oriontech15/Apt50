//
//  ApartmentController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

let notificationApartmentsUpdated = Notification.Name("apartmentsUpdated")

class ApartmentController {
    
    static let shared = ApartmentController()
    
    var apartments: [Apartment] = [] {
        didSet {
            let notification = Notification(name: notificationApartmentsUpdated)
            NotificationCenter.default.post(notification)
        }
    }
    
    func apartmentIDs() -> [String] {
        var apartmentIDs: [String] = []
        
        for apartment in Apartments.allValues {
            apartmentIDs.append(apartment.identifier)
        }
        
        return apartmentIDs
    }
    
    init() {}
    
    func checkApartments(completion: @escaping (_ apartmentIDs: [String]?) -> Void) {
        FirebaseController.ref.child("Apartments").observeSingleEvent(of: .value, with: { (snapshot) in
            let apartmentsDict = snapshot.value as? [String : [String : AnyObject]] ?? [:]
            
            var apartmentIDs = self.apartmentIDs()

            for (_, value) in apartmentsDict {
                for (key, value) in value {
                    if key == "apartmentID" {
                        if let id = value as? String {
                            if apartmentIDs.contains(id), let index = apartmentIDs.index(of: id) {
                                apartmentIDs.remove(at: index)
                            }
                        }
                    }
                }
            }
            
            print("APARTMENT-IDs: \(apartmentIDs)")
            
            if apartmentIDs.count == 0 {
                completion(nil)
            } else {
                completion(apartmentIDs)
            }
        })
    }
    
    func getApartments(completion: @escaping (_ apartments: [Apartment]?) -> Void) {
        FirebaseController.ref.child("Apartments").observeSingleEvent(of: .value, with: { (snapshot) in
            let apartmentsDict = snapshot.value as? [String : [String : AnyObject]] ?? [:]
            print("KEYS ---------> \(apartmentsDict.keys)")
            let apartments = apartmentsDict.flatMap({ Apartment(dictionary: $0.value, identifier: $0.key)})
            print("Apartments DICTIONARY: \(apartmentsDict)")
            print(apartments[0].identifier!)
            completion(apartments)
        })
    }
    
    func apartmentFor(identifier: String, completion: @escaping (_ apartment: Apartment?) -> Void) {
        FirebaseController.ref.child("Apartments").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
            let dataDictionary = snapshot.value as? [String: AnyObject] ?? [:]
            let apartment = Apartment(dictionary: dataDictionary, identifier: identifier)
            completion(apartment)
        })
    }
    
    func addPost(toApartment apartment: Apartment, postID: String) {
        var apartment = apartment
        apartment.listings.append(postID)
        apartment.save()
    }
    
    func createApartments(apartmentIDs: [String], completion: @escaping (_ complete: Bool) -> Void) {
        for apartmentID in apartmentIDs {
            for apartment in Apartments.allValues {
                if apartment.identifier == apartmentID {
                    var apartment = Apartment(name: apartment, website: apartment.website, apartmentID: apartment.identifier)
                    apartment.save()
                }
            }
        }
        
        completion(true)
    }
}











