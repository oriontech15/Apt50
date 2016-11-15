//
//  RoomTypeTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class RoomTypeTableViewCell: UITableViewCell {
        
        @IBOutlet weak var cellTypeLabel: UILabel!
        @IBOutlet weak var roomTypeSegmentedControl: CustomSegmentedControl!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            setupView()
        }
        
        func setupView() {
            roomTypeSegmentedControl.items = ["Single", "Shared"]
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
}
