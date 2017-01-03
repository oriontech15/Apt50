//
//  AppearanceController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/12/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static let shared = AppearanceController()
    
    func systemFont(name: String, size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-\(name)", size: size)
    }
    
    var selectedCollege: College = .none {
        didSet {
            let notification = Notification.Name("themeChange")
            NotificationCenter.default.post(name: notification, object: nil)
        }
    }
    
    var selectedColor: UIColor {
        return selectedCollege.color
    }
    
    var selectedThemeImage: UIImage {
        return selectedCollege.photoImage
    }
}
