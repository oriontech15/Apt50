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
    @IBOutlet weak var leftAccentView: CustomRoundedView!
    @IBOutlet weak var forwardArrowImageView: UIImageView!

    @IBOutlet weak var leftAccentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainSubLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainSubView.layer.shadowColor = UIColor.aptGray.cgColor
        mainSubView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainSubView.layer.shadowRadius = 1
        mainSubView.layer.shadowOpacity = 1.0
    }

    override func layoutSubviews() {
        
    }
    
    func updateWith(name: String, numberOfListings: Int, selectedColor: UIColor) {
        apartmentNameLabel.text = name
        numberOfListingsLabel.text = "\(numberOfListings)"
//        apartmentNameLabel.textColor = backgroundColor
        mainSubView.backgroundColor = .white
        
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
        
        apartmentNameLabel.borderColor = selectedColor
        apartmentNameLabel.borderWidth = 2
        leftAccentView.backgroundColor = selectedColor
        numberOfListingsLabel.backgroundColor = selectedColor
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
