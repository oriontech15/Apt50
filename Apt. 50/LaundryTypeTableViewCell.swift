//
//  LaundryTypeTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/15/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class LaundryTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTypeLabel: UILabel!
    @IBOutlet weak var laundryTypeSegmentedControl: CustomSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView() {
        laundryTypeSegmentedControl.items = ["Private", "Public", "Apartment"]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
