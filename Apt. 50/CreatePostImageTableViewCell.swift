//
//  CreatePostImageTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostImageTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    
    var photoID: PhotoType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }
    
    func setupCell() {
        self.photoButton.setImage(AppearanceController.shared.selectedThemeImage, for: .normal)
        self.photoImageView.contentMode = .center
    }
    
    func shrink() {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { 
            
            self.photoButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func photoButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 100:
            PostController.shared.selectedPhotoKey = .kitchen
        case 101:
            PostController.shared.selectedPhotoKey = .livingRoom
        case 102:
            PostController.shared.selectedPhotoKey = .bathRoom
        case 103:
            PostController.shared.selectedPhotoKey = .bedRoom
        default:
            break
        }
        
        
    }
}
