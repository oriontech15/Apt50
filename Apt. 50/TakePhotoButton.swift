//
//  TakePhotoButton.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/15/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class TakePhotoButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let color = AppearanceController.shared.selectedColor
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 3.5
    }
}
