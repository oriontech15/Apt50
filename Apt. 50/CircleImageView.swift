//
//  CircleImageView.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
