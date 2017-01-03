//
//  ApartmentTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ApartmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var apartmentNameLabel: CircleLabelWithBorder!
    @IBOutlet weak var numberOfListingsLabel: CircleLabelWithBorder!
    @IBOutlet weak var mainSubView: CustomRoundedView!
    var leftAccentView: UIView!
    @IBOutlet weak var forwardArrowImageView: UIImageView!

    @IBOutlet weak var mainSubLeadingConstraint: NSLayoutConstraint!
        
    let color1 = UIColor(red: 1.000, green: 0.227, blue: 0.318, alpha: 1.00).cgColor
    let color2 = UIColor(red: 1.000, green: 0.647, blue: 0.000, alpha: 1.00).cgColor
    let color3 = UIColor(red: 0.988, green: 0.200, blue: 0.769, alpha: 1.00).cgColor
    
    var gradient : CAGradientLayer?
    var toColors : [CGColor]?
    var fromColors : [CGColor]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainSubView.layer.shadowColor = UIColor.aptGray.cgColor
        mainSubView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainSubView.layer.shadowRadius = 1
        mainSubView.layer.shadowOpacity = 1.0
        
        setupView()
    }
    
    func setupView() {
        leftAccentView = UIView(frame: CGRect(x: 0, y: 0, width: mainSubView.bounds.width, height: 60))
        leftAccentView.layer.cornerRadius = leftAccentView.bounds.height / 2
        
        mainSubView.insertSubview(leftAccentView, at: 0)
        mainSubView.bringSubview(toFront: apartmentNameLabel)
        mainSubView.bringSubview(toFront: numberOfListingsLabel)
    }
    
    func reset() {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { _ in
            
            self.leftAccentView.frame = self.mainSubView.bounds
            self.leftAccentView.layer.cornerRadius = self.leftAccentView.frame.height / 2
        }, completion: {_ in
            
        })
    }
    
    func updateWith(name: String, numberOfListings: Int, selectedColor: UIColor) {
        apartmentNameLabel.text = name
        numberOfListingsLabel.text = "\(numberOfListings)"
        
        switch selectedColor {
        case UIColor.aptBYU:
            forwardArrowImageView.image = #imageLiteral(resourceName: "ForwardButtonBlue")

        case UIColor.aptUVU:
            forwardArrowImageView.image = #imageLiteral(resourceName: "ForwardButtonGreen")

        case UIColor.aptNone:
            forwardArrowImageView.image = #imageLiteral(resourceName: "ForwardButtonSalmon")

        default:
            break
        }

        mainSubView.backgroundColor = .darkGray
        numberOfListingsLabel.backgroundColor = selectedColor
        leftAccentView.backgroundColor = AppearanceController.shared.selectedCollege.color
        numberOfListingsLabel.borderColor = UIColor.white
        numberOfListingsLabel.textColor = .white
        numberOfListingsLabel.borderWidth = 1
        apartmentNameLabel.textColor = selectedColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
