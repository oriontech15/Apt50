//
//  InternetTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class InternetTableViewCell: UITableViewCell {

    @IBOutlet weak var toggleButton: CustomToggleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
