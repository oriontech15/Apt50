//
//  CustomNavigationControllerDefault.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/13/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomNavigationControllerDefault: UINavigationController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        var statusBarStyle: UIStatusBarStyle = .default
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            switch AppearanceController.shared.selectedCollege {
            case .byu:
                self.navigationBar.barTintColor = UIColor.aptBYU
                self.navigationBar.tintColor = .white
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
            case .uvu:
                self.navigationBar.barTintColor = UIColor.aptUVU
                self.navigationBar.tintColor = .white
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
            case .none:
                self.navigationBar.barTintColor = UIColor.aptNone
                self.navigationBar.tintColor = .white
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
            }
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
        
        override var childViewControllerForStatusBarStyle: UIViewController? {
            return nil
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
}

