//
//  RentPriceTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 12/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol TextUpdatedDelegate {
    func showPhotosButton()
}

class RentPriceTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var rentTextField: RoundedTextField!
    
    var textUpdatedDelegate: TextUpdatedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rentTextField.delegate = self
        setupCell()
    }
    
    func setupCell() {
        self.rentTextField.backgroundColor = AppearanceController.shared.selectedColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" && Double(textField.text!) != nil {
            self.textUpdatedDelegate?.showPhotosButton()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
