//
//  CustomToggleButton.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/15/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomToggleButton: UIButton {
    
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
    
    var myIsSelected: Bool = false
    var backgroundView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupTargets()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func shrink() {
        if !myIsSelected {
            myIsSelected = true
            print(self.myIsSelected)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { _ in
                
                self.backgroundView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }, completion: nil)
            
        } else {
            myIsSelected = false
            print(self.myIsSelected)
            UIView.animate(withDuration: 0.3, animations: { _ in
                
                self.backgroundView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                
            }, completion: {_ in
                
                self.backgroundView.backgroundColor = .clear
            })
        }
    }
    
    func grow() {
        
        if !myIsSelected {
            backgroundView.backgroundColor = color
            self.backgroundColor = UIColor.aptGray
            self.backgroundView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { _ in

                self.backgroundView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            }, completion: nil)
        } else {
            self.backgroundColor = UIColor.lightGray
        }
    }
    
    func setupTargets() {
        self.addTarget(self, action: #selector(grow), for: .touchDown)
        self.addTarget(self, action: #selector(shrink), for: .touchUpInside)
        self.backgroundView.addTarget(self, action: #selector(grow), for: .touchDown)
        self.backgroundView.addTarget(self, action: #selector(shrink), for: .touchUpInside)
    }
    
    func setupView() {
        backgroundView = UIButton(frame: CGRect(x: self.frame.origin.x + 0.5, y: self.frame.origin.y + 0.5, width: self.frame.width - 1, height: self.frame.height - 1))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.layer.cornerRadius = self.frame.height / 2
        
        if !myIsSelected {
            backgroundView.backgroundColor = .clear
        } else {
            backgroundView.backgroundColor = color
        }
        
        self.superview?.addSubview(backgroundView)
        self.superview?.bringSubview(toFront: backgroundView)
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = self.frame.height / 2
    }
}

























