//
//  CustomToggleButton.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/15/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

@IBDesignable class CustomToggleButton: UIButton {

    @IBInspectable var color: UIColor {
        get {
            switch AppearanceController.shared.selectedCollege {
            case .byu:
                return UIColor.aptBYU
            case .uvu:
                return UIColor.aptUVU
            case .none:
                return UIColor.aptNone
            }
        }
        set {
            self.color = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func setupView() {
        let backgroundView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.aptGray
        backgroundView.isHidden = true
        
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.height / 2
    }
}

























