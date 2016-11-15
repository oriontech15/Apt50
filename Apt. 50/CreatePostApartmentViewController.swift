//
//  CreatePostApartmentViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostApartmentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var apartmentNameTextField: UITextField!
    @IBOutlet weak var contactInfoButton: CustomRoundedButton!
    @IBOutlet weak var contactInfoButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var websiteLabel: UILabel!
    
    var selectedApartment: Int = 0
    
    var apartmentPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createPickerView()
        self.contactInfoButton.isEnabled = false
        self.contactInfoButton.layer.cornerRadius = self.contactInfoButton.frame.height / 2
    }
    
    func createPickerView() {
        apartmentPickerView = UIPickerView()
        apartmentPickerView.delegate = self
        apartmentPickerView.dataSource = self
        apartmentPickerView.backgroundColor = UIColor.clear
        
        let apartmentPickerBackground = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 270.0))
        let pickerViewBackground = UIView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 1000, y: 0, width: 2000, height: 500))
        let dismissButton = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 75, y: 10, width: 150, height: 40))
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.setTitle("Done", for: .normal)
        dismissButton.addTarget(self, action: #selector(endEditing), for: .touchUpInside)
        
        switch AppearanceController.shared.selectedCollege {
        case .byu:
            pickerViewBackground.backgroundColor = UIColor.aptBYU
        case .uvu:
            pickerViewBackground.backgroundColor = UIColor.aptUVU
        case .none:
            pickerViewBackground.backgroundColor = UIColor.aptNone
        }
            
        apartmentPickerBackground.backgroundColor = UIColor.white
        pickerViewBackground.layer.cornerRadius = 1000
        apartmentPickerBackground.addSubview(pickerViewBackground)
        apartmentPickerView.frame = apartmentPickerBackground.frame
        apartmentPickerBackground.addSubview(apartmentPickerView)
        apartmentPickerBackground.addSubview(dismissButton)
        
        apartmentNameTextField.delegate = self
        apartmentNameTextField.inputView = apartmentPickerBackground
        apartmentNameTextField.layer.cornerRadius = apartmentNameTextField.frame.height / 2
    }
    
    func updateTheme() {
        switch AppearanceController.shared.selectedCollege {
        case .byu:
            self.apartmentNameTextField.backgroundColor = UIColor.aptBYU.withAlphaComponent(0.85)
            self.contactInfoButton.backgroundColor = UIColor.aptBYU.withAlphaComponent(0.85)
        case .uvu:
            self.apartmentNameTextField.backgroundColor = UIColor.aptUVU.withAlphaComponent(0.85)
            self.contactInfoButton.backgroundColor = UIColor.aptUVU.withAlphaComponent(0.85)
        case .none:
            self.apartmentNameTextField.backgroundColor = UIColor.aptNone.withAlphaComponent(0.85)
            self.contactInfoButton.backgroundColor = UIColor.aptNone.withAlphaComponent(0.85)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func showNextButton(show: Bool) {
        if show {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
                self.contactInfoButtonBottomConstraint.constant = 20
                self.view.layoutIfNeeded()
                }, completion: { _ in self.contactInfoButton.isEnabled = true })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
                self.contactInfoButtonBottomConstraint.constant = -100
                self.view.layoutIfNeeded()
                }, completion: { _ in self.contactInfoButton.isEnabled = false })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        if apartmentNameTextField.text != "" {
            self.view.endEditing(true)
            let deadlineTime = DispatchTime.now() + 0.3
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [unowned self] in
                self.showNextButton(show: true)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.view.endEditing(true)
        let deadlineTime = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showNextButton(show: false)
        let apartmentName = Array(ApartmentController.shared.apartmentList().keys)[selectedApartment] 
        apartmentNameTextField.text = apartmentName
        if let website = ApartmentController.shared.apartmentList()[apartmentName] {
            self.websiteLabel.text = website
        }
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

extension CreatePostApartmentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ApartmentController.shared.apartmentList().count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let keys = Array(ApartmentController.shared.apartmentList().keys)
        return keys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let apartmentName = Array(ApartmentController.shared.apartmentList().keys)[row]
        let string = NSAttributedString(string: apartmentName, attributes: [NSForegroundColorAttributeName: UIColor.white])
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedApartment = row
        let apartmentName = Array(ApartmentController.shared.apartmentList().keys)[row]
        self.apartmentNameTextField.text = apartmentName
        if let website = ApartmentController.shared.apartmentList()[apartmentName] {
            self.websiteLabel.text = website
        }
    }
}
