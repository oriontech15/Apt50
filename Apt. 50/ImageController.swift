//
//  ImageController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    static let shared = ImageController()
    
    func mockPhotos() -> [UIImage] {
        return [#imageLiteral(resourceName: "Kitchen 1"), #imageLiteral(resourceName: "Kitchen 2"), #imageLiteral(resourceName: "Kitchen 3"), #imageLiteral(resourceName: "Kitchen 4")]
    }
}
