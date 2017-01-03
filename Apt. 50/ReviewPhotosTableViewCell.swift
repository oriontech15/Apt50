//
//  ReviewPhotosTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ReviewPhotosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kitchenImageView: UIImageView!
    @IBOutlet weak var bathroomImageView: UIImageView!
    @IBOutlet weak var bedroomImageView: UIImageView!
    @IBOutlet weak var livingRoomImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with kitchen: UIImage?, bathroom: UIImage?, bedRoom: UIImage?, livingRoom: UIImage?) {
        
        self.kitchenImageView.image = kitchen?.resizeImage(size: self.kitchenImageView.frame.size)
        self.kitchenImageView.contentMode = .center
        self.kitchenImageView.layer.cornerRadius = 10
        self.kitchenImageView.layer.masksToBounds = true
        
        self.bedroomImageView.image = bedRoom?.resizeImage(size: self.kitchenImageView.frame.size)
        self.bedroomImageView.contentMode = .center
        self.bedroomImageView.layer.cornerRadius = 10
        self.bedroomImageView.layer.masksToBounds = true

        self.bathroomImageView.image = bathroom?.resizeImage(size: self.kitchenImageView.frame.size)
        self.bathroomImageView.contentMode = .center
        self.bathroomImageView.layer.cornerRadius = 10
        self.bathroomImageView.layer.masksToBounds = true

        self.livingRoomImageView.image = livingRoom?.resizeImage(size: self.kitchenImageView.frame.size)
        self.livingRoomImageView.contentMode = .center
        self.livingRoomImageView.layer.cornerRadius = 10
        self.livingRoomImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
