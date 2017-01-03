//
//  Enums.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

enum College: String {
    case byu = "Brigham Young University"
    case uvu = "Utah Valley University"
    case none = "Default"
    
    static let allValues: [College] = [.byu, .uvu, .none]
    
    var color: UIColor {
        switch self {
        case .byu:
            return .aptBYU
        case .uvu:
            return .aptUVU
        case .none:
            return .aptNone
        }
    }
    
    var photoImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "PhotoIconBlue")
        case .uvu:
            return #imageLiteral(resourceName: "PhotoIconGreen")
        case .none:
            return #imageLiteral(resourceName: "PhotoIconSalmon")
        }
    }
    
    var backgroundImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BackgroundViewBlue")
        case .uvu:
            return #imageLiteral(resourceName: "BackgroundViewGreen")
        case .none:
            return #imageLiteral(resourceName: "BackgroundViewSalmon")
        }
    }
    
    var unselectedImages: (postList: UIImage, createPost: UIImage, profile: UIImage) {
        switch self {
        case .byu:
            return (postList: #imageLiteral(resourceName: "PostList"), createPost: #imageLiteral(resourceName: "CreatePostBlue"), profile: #imageLiteral(resourceName: "Profile"))
        case .uvu:
            return (postList: #imageLiteral(resourceName: "PostList"), createPost: #imageLiteral(resourceName: "CreatePostGreen"), profile: #imageLiteral(resourceName: "Profile"))
        case .none:
            return (postList: #imageLiteral(resourceName: "PostList"), createPost: #imageLiteral(resourceName: "CreatePost1"), profile: #imageLiteral(resourceName: "Profile"))
        }
    }
    
    var postListImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "PostListSelectedBlue")
        case .uvu:
            return #imageLiteral(resourceName: "PostListSelectedGreen")
        case .none:
            return #imageLiteral(resourceName: "PostListSelected")
        }
    }
    
    var createImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "CreatePostBlue")
        case .uvu:
            return #imageLiteral(resourceName: "CreatePostGreen")
        case .none:
            return #imageLiteral(resourceName: "CreatePost1")
        }
    }
    
    var profileImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "ProfileSelectedBlue")
        case .uvu:
            return #imageLiteral(resourceName: "ProfileSelectedGreen")
        case .none:
            return #imageLiteral(resourceName: "ProfileSelected")
        }
    }
    
    var myPostsImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "MyPostsBlue")
        case .uvu:
            return #imageLiteral(resourceName: "MyPostsGreen")
        case .none:
            return #imageLiteral(resourceName: "myPostsIcon")
        }
    }
    
    var bookmarksImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BookmarksBlue")
        case .uvu:
            return #imageLiteral(resourceName: "BookmarksGreen")
        case .none:
            return #imageLiteral(resourceName: "bookmarkIcon")
        }
    }
    
    var checkImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BlueCheck")
        case .uvu:
            return #imageLiteral(resourceName: "GreenCheck")
        case .none:
            return #imageLiteral(resourceName: "PinkCheck")
        }
    }
    
    var loginBackGround: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BlueLoginBackground")
        case .uvu:
            return #imageLiteral(resourceName: "GreenLoginBackground")
        case .none:
            return #imageLiteral(resourceName: "PinkLoginBackground")
        }
    }
    
    var backImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BackBlue")
        case .uvu:
            return #imageLiteral(resourceName: "BackGreen")
        case .none:
            return #imageLiteral(resourceName: "BackPink")
        }
    }
    
    var switchCameraImage: UIImage {
        switch self {
        case .byu:
            return #imageLiteral(resourceName: "BlueSwitchCamera")
        case .uvu:
            return #imageLiteral(resourceName: "GreenSwitchCamera")
        case .none:
            return #imageLiteral(resourceName: "PinkSwitchCamera")
        }
    }
}

enum Apartments: String {
    case kingHenry = "King Henry"
    case village = "The Village"
    case branbury = "The Branbury"
    case belmont = "Belmont Apartment"
    
    static var allValues: [Apartments] { return [.kingHenry, .village, .branbury, .belmont] }
    
    var website: String {
        
        switch self {
        case .kingHenry:
            return "www.kinghenry.com"
        case .village:
            return "www.thevillageatsouthcampus.com"
        case .branbury:
            return "www.thebranbury.com"
        case .belmont:
            return "www.belmontapts.net"
        }
    }
    
    var identifier: String {
        switch self {
        case .kingHenry:
            return "0-kinghenry--apts-00"
        case .village:
            return "0-village--apts-01"
        case .branbury:
            return "0-branbury--apts-02"
        case .belmont:
            return "0-belmont--apts-03"
        }
    }
}

enum RoomType: String {
    case sharedRoom = "Shared"
    case privateRoom = "Private"
    
    static let allValues: [RoomType] = [.sharedRoom, .privateRoom]
}

enum ApartmentType: String {
    case married = "Married"
    case male = "Male"
    case female = "Female"
    
    static let allValues: [ApartmentType] = [.married, .female, .male]
}

enum LaundryType: String {
    case privateLaundry = "Private"
    case apartment = "Apartment"
    case publicLaundry = "Public"
    
    static let allValues: [LaundryType] = [.privateLaundry, .apartment, .publicLaundry]
}

enum TVType: String {
    case included = "Yes"
    case notIncluded = "No"
}

enum InternetType: String {
    case included = "Yes"
    case notIncluded = "No"
}

enum ParkingType: String {
    case included = "Yes"
    case notIncluded = "No"
}

enum PhotoType: String {
    case kitchen = "Kitchen"
    case livingRoom = "Living Room"
    case bedRoom = "Bed Room"
    case bathRoom = "Bath Room"
    case none = "Other"
}
