//
//  Extensions.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension String {
    var decrypted: Character {
        switch self {
        case "-az":
            return "0"
        case "0ba":
            return "1"
        case "&cb":
            return "2"
        case "Edc":
            return "3"
        case "4ed":
            return "4"
        case "fee":
            return "5"
        case "g9d":
            return "6"
        case "hc!":
            return "7"
        case "i#b":
            return "8"
        case "ja_":
            return "9"
        case "55d":
            return "a"
        case "01z":
            return "A"
        case "3ga":
            return "b"
        case "_0a":
            return "B"
        case "8qz":
            return "c"
        case "02y":
            return "C"
        case "8t;":
            return "d"
        case "-vb":
            return "D"
        case "&e5":
            return "e"
        case "_3x":
            return "E"
        case "dd2":
            return "f"
        case "0vc":
            return "F"
        case "99e":
            return "g"
        case "14w":
            return "G"
        case "0rp":
            return "h"
        case "'5d":
            return "H"
        case "Z4E":
            return "i"
        case "_2v":
            return "I"
        case "uu8":
            return "j"
        case "@ve":
            return "J"
        case "2@v":
            return "k"
        case "#8U":
            return "K"
        case "q1K":
            return "l"
        case "-1f":
            return "L"
        case "1xs":
            return "m"
        case "&9T":
            return "M"
        case "t0z":
            return "n"
        case "t3g":
            return "N"
        case "Iw9":
            return "o"
        case "0aS":
            return "O"
        case "4rQ":
            return "p"
        case "9xh":
            return "P"
        case "tw6":
            return "q"
        case "l,R":
            return "Q"
        case "s0#":
            return "r"
        case "_vi":
            return "R"
        case "q9x":
            return "s"
        case "q_q":
            return "S"
        case "C3P":
            return "t"
        case "Y0j":
            return "T"
        case "IIi":
            return "u"
        case "WvP":
            return "U"
        case "i7u":
            return "v"
        case "Q7k":
            return "V"
        case "0p9":
            return "w"
        case "Yso":
            return "W"
        case "_4i":
            return "x"
        case "Zll":
            return "X"
        case "2x-":
            return "y"
        case "JvN":
            return "Y"
        case "-4m":
            return "z"
        case "0cm":
            return "Z"
        case "_0_":
            return " "
        case "-!o":
            return "#"
        case "-!@":
            return "@"
        case "-!q":
            return "$"
        case "---":
            return "-"
        default:
            return "_"
        }
    }
}
extension Character {
    
    var encrypted: String {
        switch self {
        case "0":
            return "-az"
        case "1":
            return "0ba"
        case "2":
            return "&cb"
        case "3":
            return "Edc"
        case "4":
            return "4ed"
        case "5":
            return "fee"
        case "6":
            return "g9d"
        case "7":
            return "hc!"
        case "8":
            return "i#b"
        case "9":
            return "ja_"
        case "a":
            return "55d"
        case "A":
            return "01z"
        case "b":
            return "3ga"
        case "B":
            return "_0a"
        case "c":
            return "8qz"
        case "C":
            return "02y"
        case "d":
            return "8t;"
        case "D":
            return "-vb"
        case "e":
            return "&e5"
        case "E":
            return "_3x"
        case "f":
            return "dd2"
        case "F":
            return "0vc"
        case "g":
            return "99e"
        case "G":
            return "14w"
        case "h":
            return "0rp"
        case "H":
            return "'5d"
        case "i":
            return "Z4E"
        case "I":
            return "_2v"
        case "j":
            return "uu8"
        case "J":
            return "@ve"
        case "k":
            return "2@v"
        case "K":
            return "#8U"
        case "l":
            return "q1K"
        case "L":
            return "-1f"
        case "m":
            return "1xs"
        case "M":
            return "&9T"
        case "n":
            return "t0z"
        case "N":
            return "t3g"
        case "o":
            return "Iw9"
        case "O":
            return "0aS"
        case "p":
            return "4rQ"
        case "P":
            return "9xh"
        case "q":
            return "tw6"
        case "Q":
            return "l,R"
        case "r":
            return "s0#"
        case "R":
            return "_vi"
        case "s":
            return "q9x"
        case "S":
            return "q_q"
        case "t":
            return "C3P"
        case "T":
            return "Y0j"
        case "u":
            return "IIi"
        case "U":
            return "WvP"
        case "v":
            return "i7u"
        case "V":
            return "Q7k"
        case "w":
            return "0p9"
        case "W":
            return "Yso"
        case "x":
            return "_4i"
        case "X":
            return "Zll"
        case "y":
            return "2x-"
        case "Y":
            return "JvN"
        case "z":
            return "-4m"
        case "Z":
            return "0cm"
        case "#":
            return "-!o"
        case "@":
            return "-!@"
        case "$":
            return "-!q"
        case "-":
            return "---"
        case " ":
            return "_0_"
        default:
            return ""
        }
    }
}

extension Int {
    var stringRep: String {
        return "\(self)"
    }
}

extension Double {
    var currency: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        if let currency = numberFormatter.string(from: NSNumber(value: self)) {
            return currency
        } else {
            return ""
        }
    }
    
    var stringRep: String {
        return "\(self)"
    }
}

extension UIImage {
    
    func resizeImage(size: CGSize) -> UIImage? {
        let scale = max(size.width / self.size.width, size.height / self.size.height)
        let width = self.size.width * scale
        let height = self.size.height * scale;
        let imageRect = CGRect(x: (size.width - width) / 2.0, y: (size.height - height) / 2.0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func rotateImage() -> UIImage? {
        if let cgImage = self.cgImage {
            return UIImage(cgImage: cgImage, scale: CGFloat(1.0), orientation: .right)
        } else {
            return nil
        }
    }
}

extension UIView {
    
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
        return UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00)
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
