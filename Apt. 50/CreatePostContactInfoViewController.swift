//
//  CreatePostContactInfoViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostContactInfoViewController: UIViewController {

    @IBOutlet weak var editButton: CustomRoundedButton!
    @IBOutlet weak var confirmButton: CustomRoundedButton!
    @IBOutlet weak var apartmentInfoButton: CustomRoundedButton!
    
    @IBOutlet weak var apartmentInfoButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    
    var selectColor: UIColor = UIColor.aptNone

    override func viewDidLoad() {
        super.viewDidLoad()

        self.apartmentInfoButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch AppearanceController.shared.selectedCollege {
        case .byu:
            selectColor = UIColor.aptBYU
        case .uvu:
            selectColor = UIColor.aptUVU
        case .none:
            selectColor = UIColor.aptNone
        }
        
        for textField in textFields {
            textField.backgroundColor = selectColor.withAlphaComponent(0.85)
        }
        
        editButton.backgroundColor = selectColor
        confirmButton.backgroundColor = selectColor
        apartmentInfoButton.backgroundColor = selectColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editButtonTapped(_ sender: AnyObject) {
        confirmButton.isEnabled = true
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.borderWidth = 0
        confirmButton.layer.borderColor = nil
        confirmButton.backgroundColor = selectColor
        
        for textField in textFields {
            textField.isHidden = false
        }
        
        self.nameLabel.alpha = 0.0
        self.phoneLabel.alpha = 0.0
        self.emailLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            self.nameTextFieldLeadingConstraint.constant = 35
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            self.phoneTextFieldLeadingConstraint.constant = 35
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            self.emailTextFieldLeadingConstraint.constant = 35
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @IBAction func confirmButtonTapped(_ sender: AnyObject) {
        
        confirmButton.setTitleColor(selectColor, for: .normal)
        confirmButton.backgroundColor = .white
        confirmButton.layer.borderWidth = 2
        confirmButton.layer.borderColor = selectColor.cgColor
        confirmButton.isEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            
            self.nameTextFieldLeadingConstraint.constant = 400
            self.phoneTextFieldLeadingConstraint.constant = 400
            self.emailTextFieldLeadingConstraint.constant = 400
            self.view.layoutIfNeeded()
            }, completion: { (_) in
                
                self.nameTextFieldLeadingConstraint.constant = -400
                self.phoneTextFieldLeadingConstraint.constant = -400
                self.emailTextFieldLeadingConstraint.constant = -400
                
                for textField in self.textFields {
                    textField.isHidden = true
                }
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            
            self.nameLabel.alpha = 1.0
            self.phoneLabel.alpha = 1.0
            self.emailLabel.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            self.apartmentInfoButtonConstraint.constant = 20
            self.view.layoutIfNeeded()
            }, completion: { _ in self.apartmentInfoButton.isEnabled = true })
    }
    
    @IBAction func apartmentInfoButtonTapped(_ sender: AnyObject) {
        print("Apartment Button Tapped")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
