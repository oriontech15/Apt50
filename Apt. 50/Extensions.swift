//
//  Extensions.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
}

extension Int {
    var stringRep: String {
        return "\(self)"
    }
}

extension Double {
    var stringRep: String {
        return "\(self)"
    }
}

extension Date {
    func dateString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    var long: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    var medium: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    var short: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension TimeInterval {
    
}

extension UIColor {
    static var aptGray: UIColor {
        return UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1.00)
    }
    
    static var aptUVU: UIColor {
        return UIColor(red: 0.067, green: 0.776, blue: 0.192, alpha: 1.00)
    }
    
    static var aptBYU: UIColor {
        return UIColor(red: 0.000, green: 0.663, blue: 0.800, alpha: 1.00)
    }

    static var aptNone: UIColor {
        return UIColor(red: 1.000, green: 0.533, blue: 0.510, alpha: 1.00)
    }
}
