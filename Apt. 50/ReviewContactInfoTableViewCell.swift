//
//  ReviewContactInfoTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ReviewContactInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var sectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with name: String, phone: String, email: String?) {
        
        self.nameLabel.text = name
        self.phoneLabel.text = phone
        
        if let email = email {
            self.emailLabel.text = email
        } else {
            self.emailLabel.isHidden = true
            self.emailTitleLabel.isHidden = true
        }
        
        self.sectionView.layer.cornerRadius = self.sectionView.frame.height / 2
        self.sectionView.backgroundColor = AppearanceController.shared.selectedColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
