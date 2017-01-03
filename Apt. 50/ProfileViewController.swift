//
//  ProfileViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var bookmarksButton: UIButton!
    @IBOutlet weak var bookmarksLabel: UILabel!
    @IBOutlet weak var myPostsLabel: UILabel!
    @IBOutlet weak var myPostsButton: UIButton!
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var dividerView: CircleView!
    @IBOutlet weak var imageBorderView: CircleView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var changeCollegeView: UIView!
    @IBOutlet weak var universityTitleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var settingsViewBottomConstraint: NSLayoutConstraint!
    
    var firstLoad = true
    
    var settingsViewUp: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.settingsViewBottomConstraint.constant = -164
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: NSNotification.Name("themeChange"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTextFields()
        
        self.view.setNeedsLayout()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        
        
        if UserController.shared.tempProfilePhoto.count > 0 {
            UserController.shared.tempProfilePhoto = [:]
            let image = UserController.shared.tempProfilePhoto["profile"]?.resizeImage(size: self.profileImageView.frame.size)
            self.profileImageView.image = image
            
            UserController.shared.updateProfileImage(image: image!, completion: { (_) in
                print("updated")
            })
        } else {
            UserController.shared.getProfileImage(completion: { (image) in
                if let image = image {
                    self.profileImageView.image = image
                } else {
                    print("Could not find a profile image")
                }
            })
        }
        
        updateTheme()
    }
    
    func setupTextFields() {
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        phoneTextField.layer.cornerRadius = phoneTextField.frame.height / 2
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        
        let currentUser = UserController.shared.user
        
        if let contactInfo = currentUser?.contactInfo, let email = contactInfo.email {
            
            nameTextField.text = contactInfo.contactName
            phoneTextField.text = contactInfo.phoneNumber
            emailTextField.text = email
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let user = UserController.shared.user else { return }
        guard let email = emailTextField.text, emailTextField.text!.contains("@") || emailTextField.text! == "" else { return }
        guard let phone = phoneTextField.text, (Int(phoneTextField.text!) != nil) else { return }
        guard let name = nameTextField.text, nameTextField.text != "" else { return }
        
        ContactInfoController.shared.updateContactInfo(forUser: user, name: name, email: email, phone: phone) { (contactInfo) in
            print(contactInfo!)
        }
    }
    
    func updateTheme() {
        
        let selectedCollege = AppearanceController.shared.selectedCollege
        
        self.universityTitleLabel.text = selectedCollege.rawValue
        self.view.backgroundColor = selectedCollege.color
        self.changeCollegeView.backgroundColor = selectedCollege.color
        self.dividerView.backgroundColor = selectedCollege.color
        self.imageBorderView.backgroundColor = selectedCollege.color
        self.bookmarksButton.setImage(selectedCollege.bookmarksImage, for: .normal)
        self.myPostsButton.setImage(selectedCollege.myPostsImage, for: .normal)
        
        self.tabBarController?.tabBar.items?[0].image = selectedCollege.unselectedImages.postList.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].image = selectedCollege.unselectedImages.createPost.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].image = selectedCollege.unselectedImages.profile.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[0].selectedImage = selectedCollege.postListImage.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].selectedImage = selectedCollege.createImage.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].selectedImage = selectedCollege.profileImage.withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func myPostsButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func bookmarksButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func imageViewTapped(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toCameraView", sender: nil)
    }
    
    @IBAction func changeCollegeTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CollegeSelectView") as! CollegeSelectViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func updateContactInfoTapped(_ sender: UITapGestureRecognizer) {
        moveSettingsViewDown()
    }
    
    func moveSettingsViewDown() {
        if settingsViewUp {
            settingsViewUp = false
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.arrowImageView.image = #imageLiteral(resourceName: "DownButton")
                self.settingsViewBottomConstraint.constant = -390
                self.settingsView.layer.cornerRadius = 750
                self.myPostsLabel.alpha = 0.0
                self.bookmarksLabel.alpha = 0.0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            settingsViewUp = true
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.arrowImageView.image = #imageLiteral(resourceName: "ForwardButton")
                self.settingsViewBottomConstraint.constant = -164
                self.settingsView.layer.cornerRadius = 0
                self.myPostsLabel.alpha = 1.0
                self.bookmarksLabel.alpha = 1.0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toCameraView" {
            let vc = segue.destination as! CameraViewController
            
            vc.previousVC = "profile"
        }
    }
    
}
