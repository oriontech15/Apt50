//
//  ProfileViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var bookmarksButton: UIButton!
    @IBOutlet weak var myPostsButton: UIButton!
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var dividerView: CircleView!
    @IBOutlet weak var imageBorderView: CircleView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var blueButton: CustomRoundedButton!
    @IBOutlet weak var salmonButton: CustomRoundedButton!
    @IBOutlet weak var greenButton: CustomRoundedButton!
    
    @IBOutlet weak var settingsViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var blueButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var greenButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var greenButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var salmonButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var salmonButtonWidth: NSLayoutConstraint!
    
    
    var settingsViewUp: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: NSNotification.Name("themeChange"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
    }
    
    func updateTheme() {
        
        switch AppearanceController.shared.selectedCollege {
        case .byu:
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.aptBYU
                self.dividerView.backgroundColor = UIColor.aptBYU
                self.imageBorderView.backgroundColor = UIColor.aptBYU
                self.bookmarksButton.setImage(#imageLiteral(resourceName: "BookmarksBlue"), for: .normal)
                self.myPostsButton.setImage(#imageLiteral(resourceName: "MyPostsBlue"), for: .normal)
            })
            
            blueButton.layer.borderWidth = 4
            blueButton.layer.borderColor = UIColor.darkGray.cgColor
            blueButtonHeight.constant = 60
            blueButtonWidth.constant = 60
            blueButton.cornerRadius = 30
            greenButtonHeight.constant = 40
            greenButtonWidth.constant = 40
            greenButton.cornerRadius = 20
            salmonButtonHeight.constant = 40
            salmonButtonWidth.constant = 40
            salmonButton.cornerRadius = 20
            salmonButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 0
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePostBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelectedBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePostBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelectedBlue").withRenderingMode(.alwaysOriginal)
        case .uvu:
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.aptUVU
                self.dividerView.backgroundColor = UIColor.aptUVU
                self.imageBorderView.backgroundColor = UIColor.aptUVU
                self.bookmarksButton.setImage(#imageLiteral(resourceName: "BookmarksGreen"), for: .normal)
                self.myPostsButton.setImage(#imageLiteral(resourceName: "MyPostsGreen"), for: .normal)
            })
            
            blueButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 4
            blueButtonHeight.constant = 40
            blueButtonWidth.constant = 40
            blueButton.cornerRadius = 20
            greenButtonHeight.constant = 60
            greenButtonWidth.constant = 60
            greenButton.cornerRadius = 30
            salmonButtonHeight.constant = 40
            salmonButtonWidth.constant = 40
            salmonButton.cornerRadius = 20
            greenButton.layer.borderColor = UIColor.darkGray.cgColor
            salmonButton.layer.borderWidth = 0
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePostGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelectedGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePostGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelectedGreen").withRenderingMode(.alwaysOriginal)
        case .none:
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.aptNone
                self.dividerView.backgroundColor = UIColor.aptNone
                self.imageBorderView.backgroundColor = UIColor.aptNone
                self.bookmarksButton.setImage(#imageLiteral(resourceName: "bookmarkIcon"), for: .normal)
                self.myPostsButton.setImage(#imageLiteral(resourceName: "myPostsIcon"), for: .normal)
            })
            
            blueButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 0
            blueButtonHeight.constant = 40
            blueButtonWidth.constant = 40
            blueButton.cornerRadius = 20
            greenButtonHeight.constant = 40
            greenButtonWidth.constant = 40
            greenButton.cornerRadius = 20
            salmonButtonHeight.constant = 60
            salmonButtonWidth.constant = 60
            salmonButton.cornerRadius = 30
            salmonButton.layer.borderWidth = 4
            salmonButton.layer.borderColor = UIColor.darkGray.cgColor
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePost1").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelected").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePost1").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelected").withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    @IBAction func myPostsButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func bookmarksButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            blueButton.layer.borderWidth = 4
            blueButton.layer.borderColor = UIColor.darkGray.cgColor
            blueButtonHeight.constant = 60
            blueButtonWidth.constant = 60
            blueButton.cornerRadius = 30
            greenButtonHeight.constant = 40
            greenButtonWidth.constant = 40
            greenButton.cornerRadius = 20
            salmonButtonHeight.constant = 40
            salmonButtonWidth.constant = 40
            salmonButton.cornerRadius = 20
            salmonButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 0
        case 1:
            blueButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 4
            blueButtonHeight.constant = 40
            blueButtonWidth.constant = 40
            blueButton.cornerRadius = 20
            greenButtonHeight.constant = 60
            greenButtonWidth.constant = 60
            greenButton.cornerRadius = 30
            salmonButtonHeight.constant = 40
            salmonButtonWidth.constant = 40
            salmonButton.cornerRadius = 20
            greenButton.layer.borderColor = UIColor.darkGray.cgColor
            salmonButton.layer.borderWidth = 0
        case 2:
            blueButton.layer.borderWidth = 0
            greenButton.layer.borderWidth = 0
            blueButtonHeight.constant = 40
            blueButtonWidth.constant = 40
            blueButton.cornerRadius = 20
            greenButtonHeight.constant = 40
            greenButtonWidth.constant = 40
            greenButton.cornerRadius = 20
            salmonButtonHeight.constant = 60
            salmonButtonWidth.constant = 60
            salmonButton.cornerRadius = 30
            salmonButton.layer.borderWidth = 4
            salmonButton.layer.borderColor = UIColor.darkGray.cgColor
        default:
            break
        }
        
        for option in AppearanceController.College.allTypes {
            if sender.tag == option.rawValue {
                AppearanceController.shared.selectedCollege = option
            }
        }
    }
    
    @IBAction func imageViewTapped(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toCameraView", sender: nil)
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
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        } else {
            settingsViewUp = true
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.arrowImageView.image = #imageLiteral(resourceName: "ForwardButton")
                self.settingsViewBottomConstraint.constant = -148
                self.settingsView.layer.cornerRadius = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
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
