//
//  CircleLabelWithBorder.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CircleLabelWithBorder: UILabel {
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var border: Bool = false {
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
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
        if border {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
