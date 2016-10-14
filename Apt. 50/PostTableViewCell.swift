//
//  PostTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceInfoView: CustomRoundedView!
    @IBOutlet weak var mainSubView: CustomRoundedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainSubView.layer.shadowColor = UIColor.aptGray.cgColor
        mainSubView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainSubView.layer.shadowRadius = 1
        mainSubView.layer.shadowOpacity = 1.0
    }
    
    func updateWith(image: UIImage, color: UIColor, price: String) {
        self.priceLabel.text = "$" + price + " /mo"
        self.priceInfoView.backgroundColor = color
        self.postImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
