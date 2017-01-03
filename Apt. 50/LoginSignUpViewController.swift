//
//  ViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginSignUpViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var apartmentLabel: UILabel!
    @IBOutlet weak var titleSeparatorViewWidth: NSLayoutConstraint!
    @IBOutlet weak var socialStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var loginSignupLabel: UILabel!
    @IBOutlet weak var fiftyLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var titleSeparatorView: UIView!
    @IBOutlet weak var fiftyLabel: UILabel!
    @IBOutlet weak var loginButton: CustomRoundedButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mainStackCenterY: NSLayoutConstraint!
    @IBOutlet weak var changeCollegeButton: UIButton!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var nameTextField: RoundedTextField!
    @IBOutlet weak var phoneTextField: RoundedTextField!
    
    @IBOutlet weak var orView: UIView!
    @IBOutlet var textFields: [RoundedTextField]!
    
    var login: Bool = true
    var collegeSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        for textField in textFields {
            textField.delegate = self
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatedCollege), name: Notification.Name("themeChange"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movefiftyLabel()
        setupBackgroundImageView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.backgroundImageView.alpha = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatedCollege() {
        
        UIView.animate(withDuration: 0.8) {
            self.changeCollegeButton.alpha = 1.0
        }
        
        self.collegeSelected = true
        self.loginButton.setTitle("Sign Up", for: .normal)
        
        let color = AppearanceController.shared.selectedColor
        let image = AppearanceController.shared.selectedCollege.loginBackGround
        
        loginButton.backgroundColor = color
        backgroundImageView.image = image
        
        for textField in textFields {
            textField.backgroundColor = color.withAlphaComponent(0.5)
        }
    }
    
    func movefiftyLabel() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 1.0) {
                self.apartmentLabel.alpha = 1.0
                self.fiftyLabel.alpha = 1.0
                self.titleSeparatorView.alpha = 1.0
            }
            UIView.animate(withDuration: 1.3, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
                self.titleSeparatorViewWidth.constant = 250
                self.fiftyLabelTrailing.constant = 20
                self.view.layoutIfNeeded()
                }, completion: {_ in
                    UIView.animate(withDuration: 0.4, animations: { [unowned self] in
                        self.emailStackView.alpha = 1.0
                        }, completion: { (_) in
                            UIView.animate(withDuration: 0.4, animations: { [unowned self] in
                                self.passwordStackView.alpha = 1.0
                                }, completion: { (_) in
                                    UIView.animate(withDuration: 0.4, animations: { [unowned self] in
                                        self.orView.alpha = 1.0
                                        }, completion: { (_) in
                                            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                                                self.socialStackView.alpha = 1.0
                                                }, completion: {_ in
                                                    UIView.animate(withDuration: 0.4,
                                                                   delay: 0.0,
                                                                   usingSpringWithDamping: 0.8,
                                                                   initialSpringVelocity: 0.6,
                                                                   options: [],
                                                                   animations: {
                                                                    self.bottomViewBottomConstraint.constant = 0
                                                                    self.view.layoutIfNeeded()
                                                    }, completion: nil)
                                            })
                                    })
                            })
                    })
            })
        }
    }
    
    func setupBackgroundImageView() {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.backgroundImageView.alpha = 0.2
        }, completion: nil)
    }
    
    func presentErrorAlert(errorMessage: String, errorCode: String) {
        let alert = UIAlertController(title: "Error: " + errorCode, message: errorMessage, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel) { (_) in }
        alert.addAction(okayAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectCollegeButtonTapped(_ sender: UIButton) {
        if !login {
            if collegeSelected {
                signUp()
            } else {
                self.performSegue(withIdentifier: "selectCollegeSegue", sender: nil)
            }
        } else {
            signIn()
        }
    }
    
    func signUp() {
        SecurityController.shared.signUp(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phone: phoneTextField.text!, completion: { (user, error) in
            if let error = error {
                self.presentErrorAlert(errorMessage: error.errorMessage, errorCode: error.errorCode)
            } else {
                print("Signed In User with UserID: \(user?.identifier)")
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func signIn() {
        SecurityController.shared.signInGeneral(email: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if let error = error {
                self.presentErrorAlert(errorMessage: error.errorMessage, errorCode: error.errorCode)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func googleSignButtonTapped() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        SecurityController.shared.signInGoogle(crediential: credential, userID: user.userID) { (user, error) in
            if let error = error {
                self.presentErrorAlert(errorMessage: error.errorMessage, errorCode: error.errorCode)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser ,
              withError error: Error!) {
        
    }
    
    @IBAction func changeCollegeButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "selectCollegeSegue", sender: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        if !login {
            
            self.loginSignupLabel.text = "Need an account?"
            self.loginButton.setTitle("Login", for: .normal)
            self.socialStackView.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.orView.alpha = 1.0
                self.changeCollegeButton.alpha = 0.0
                sender.setTitle("Sign up", for: .normal)
                self.nameStackView.alpha = 0.0
                self.phoneStackView.alpha = 0.0
                self.mainStackCenterY.constant = -40
                self.facebookButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.googleButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.nameStackView.isHidden = true
                self.phoneStackView.isHidden = true
                self.login = !self.login
            }, completion: {_ in
                
            })
        } else {
            
            self.loginSignupLabel.text = "Have an account?"
            
            if self.collegeSelected {
                self.loginButton.setTitle("Sign Up", for: .normal)
                self.changeCollegeButton.alpha = 1.0
            } else {
                self.loginButton.setTitle("Select College", for: .normal)
                
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.orView.alpha = 0.0
                sender.setTitle("Login", for: .normal)
                self.nameStackView.alpha = 1.0
                self.phoneStackView.alpha = 1.0
                self.mainStackCenterY.constant = 0
                self.facebookButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.googleButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.nameStackView.isHidden = false
                self.phoneStackView.isHidden = false
                self.login = !self.login
            }, completion: {_ in
                
                self.socialStackView.isHidden = true
            })
        }
    }
    
    @IBAction func screenTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
