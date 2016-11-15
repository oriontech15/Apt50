//
//  FirebaseController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit


class FirebaseController {
    //static let ref = FIRDatabase.database().reference()
    //static let storage = FIRStorage.storage().reference()
}

protocol FirebaseType {
    var endpoint: String {get}
    var identifier: String? {get set}
    var dictionaryCopy: [String: AnyObject] {get}
    
    init?(dictionary: [String: AnyObject], identifier: String)
    
    //mutating func save()
    //func delete()
}

/*
extension FirebaseType {
    
    mutating func save() {
        var newEndpoint = FirebaseController.ref.child(endpoint)
        if let identifier = identifier {
            newEndpoint = newEndpoint.child(identifier)
            newEndpoint.updateChildValues(dictionaryCopy)
        } else {
            newEndpoint = newEndpoint.childByAutoId()
            self.identifier = newEndpoint.key
            newEndpoint.setValue(dictionaryCopy)
        }
        //        newEndpoint.setValue(dictionaryCopy)
    }
    
    func delete() {
        guard let identifier = identifier else {
            return
        }
        FirebaseController.ref.child(endpoint).child(identifier).removeValue()
    }
}*/
