//
//  ReviewApartmentInfoTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ReviewApartmentInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var apartmentTypeLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var laundryTypeLabel: UILabel!
    @IBOutlet weak var tvTypeLabel: UILabel!
    @IBOutlet weak var internetTypeLabel: UILabel!
    @IBOutlet weak var parkingTypeLabel: UILabel!
    @IBOutlet weak var monthlyRentLabel: UILabel!
    @IBOutlet weak var sectionView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(apartmentType: String, roomType: String, laundryType: String, tvType: String, internetType: String, parkingType: String, montlyRent: String) {
        
        self.sectionView.layer.cornerRadius = self.sectionView.frame.height / 2
        
        self.sectionView.backgroundColor = AppearanceController.shared.selectedColor
        
        self.apartmentTypeLabel.text = apartmentType
        self.roomTypeLabel.text = roomType
        self.laundryTypeLabel.text = laundryType
        self.tvTypeLabel.text = tvType
        self.internetTypeLabel.text = internetType
        self.parkingTypeLabel.text = parkingType
        self.monthlyRentLabel.text = montlyRent
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
