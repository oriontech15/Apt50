//
//  CollegeTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/16/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CollegeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collegeColorView: CircleView!
    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var selectBorderView: UIView!
    
    var color: UIColor = .white

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(color: UIColor, name: String) {
        self.collegeColorView.backgroundColor = color
        self.collegeNameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.selectBorderView.layer.cornerRadius = self.selectBorderView.frame.height / 2
            self.selectBorderView.layer.borderColor = color.cgColor
            self.selectBorderView.layer.borderWidth = 2
        } else {
            self.selectBorderView.layer.borderColor = UIColor.clear.cgColor
            self.selectBorderView.layer.borderWidth = 0
        }
    }

}
