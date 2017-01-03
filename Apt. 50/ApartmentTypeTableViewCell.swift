//
//  ApartmentTypeTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ApartmentTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTypeLabel: UILabel!
    @IBOutlet weak var apartmentTypeSegmentedControl: CustomSegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView() {
        apartmentTypeSegmentedControl.items = ["Male", "Female", "Married"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
