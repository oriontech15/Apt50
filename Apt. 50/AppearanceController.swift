//
//  AppearanceController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/12/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation

class AppearanceController {
    enum College: Int {
        case byu = 0
        case uvu = 1
        case none = 2
        
        static let allTypes = [byu, uvu, none]
    }
    
    static let shared = AppearanceController()
    
    var selectedCollege: College = .none {
        didSet {
            let notification = Notification.Name("themeChange")
            NotificationCenter.default.post(name: notification, object: nil)
        }
    }
}
