//
//  ProgressView.swift
//  Apt. 50
//
//  Created by Justin Smith on 12/19/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var progressEnd: CGFloat {
        return self.frame.width
    }
    
    var progressRate: CGFloat {
        return progressEnd / 100
    }
    
    var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    var progressBar: UIView!
    //lazy var progressLabel: UILabel = UILabel(frame: CGRect(x: self.frame.width - 15, y: 10, width: 30, height: 15))
    lazy var titleLabel: UILabel = UILabel(frame: CGRect(x: 10, y: -30, width: 150, height: 25))
    
    lazy var font = UIFont(name: "Avenir-Book", size: 10)
    
    init(startingPoint: CGPoint, width: CGFloat, bgColor: UIColor, title: String) {
        let borderColor = bgColor.withAlphaComponent(0.2).cgColor
        let frame = CGRect(x: startingPoint.x, y: startingPoint.y, width: width - 40, height: 8)
        super.init(frame: frame)
        
        progressBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height))

        setupView(frame: frame, bgColor: bgColor, borderColor: borderColor, title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress() {
        let progressLine = (progress * progressRate)
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {_ in
            
            //self.progressLabel.frame = CGRect(x: progressLine - (10), y: 10, width: 25, height: 15)
            self.progressBar.frame = CGRect(x: 0, y: 0, width: progressLine, height: self.frame.height)
            
            self.setNeedsDisplay()
            self.layoutIfNeeded()
        }, completion: nil)
        
        //self.progressLabel.text = "\(Int(self.progress))%"
    }
    
    
    
    func setupView(frame: CGRect, bgColor: UIColor, borderColor: CGColor?, title: String) {
        self.backgroundColor = bgColor.withAlphaComponent(0.5)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 0.5
        
        progressBar.backgroundColor = bgColor.withAlphaComponent(1.0)
        progressBar.layer.cornerRadius = progressBar.frame.height / 2
        
//        progressLabel.font = font
//        progressLabel.textColor = bgColor.withAlphaComponent(1.0)
//        progressLabel.textAlignment = .center
        
//        titleLabel.text = title
//        titleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
//        titleLabel.textColor = bgColor.withAlphaComponent(1.0)
//        titleLabel.textAlignment = .left
        
        self.addSubview(progressBar)
        //self.addSubview(progressLabel)
        //self.addSubview(titleLabel)
    }
}
