//
//  CustomButton.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomRoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        if shadow {
            self.layer.shadowRadius = 3
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.7
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
