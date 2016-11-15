//
//  CustomTabBarController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let items = self.tabBar.items
        {
            for item in items
            {
                if let image = item.image, let selectedImage = item.selectedImage
                {
                    item.title = nil
                    item.image = image.withRenderingMode( .alwaysOriginal )
                    item.selectedImage = selectedImage.withRenderingMode( .alwaysOriginal )
                }
                
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            }
        }
        
        addDividers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        let kBarHeight: CGFloat = 60.0
        var tabFrame = self.tabBar.frame //self.TabBar is IBOutlet of your TabBar
        tabFrame.size.height = kBarHeight
        tabFrame.origin.y = self.view.frame.size.height - kBarHeight
        self.tabBar.frame = tabFrame        
    }
    
    func addDividers() {
        let dividerViewLeft = UIView(frame: CGRect(x: UIScreen.main.bounds.width / 3, y: self.view.frame.height - 50 , width: 1, height: 40))
        dividerViewLeft.backgroundColor = .darkGray
        
        let dividerViewRight = UIView(frame: CGRect(x: UIScreen.main.bounds.width - UIScreen.main.bounds.width / 3, y: self.view.frame.height - 50, width: 1, height: 40))
        dividerViewRight.backgroundColor = .darkGray
        
        self.view.addSubview(dividerViewLeft)
        self.view.addSubview(dividerViewRight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
