//
//  ReviewApartmentTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ReviewApartmentTableViewCell: UITableViewCell {

    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var apartmentWebsiteLabel: UILabel!
    
    @IBOutlet weak var sectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with apartment: Apartments) {
        self.apartmentNameLabel.text = apartment.rawValue
        self.apartmentWebsiteLabel.text = apartment.website
        
        self.sectionView.layer.cornerRadius = self.sectionView.frame.height / 2
        self.sectionView.backgroundColor = AppearanceController.shared.selectedColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
