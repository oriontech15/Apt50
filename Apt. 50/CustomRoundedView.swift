//
//  CustomRoundedView.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

@IBDesignable
class CustomRoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var border: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var maskOn: Bool = false {
        didSet {
            setupView()
        }
    }
    
    var gradient = false {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = cornerRadius
        
        if maskOn {
            self.layer.masksToBounds = true
        } else {
            self.layer.masksToBounds = false
        }
        
        if border {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 0.8
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
