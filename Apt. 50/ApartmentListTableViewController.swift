//
//  PostListTableViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ApartmentListTableViewController: UITableViewController {
    
    var apartments: [Apartment] {
        return ApartmentController.shared.mockApartments()
    }
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    var selectedThemeColor: UIColor = UIColor.aptNone
    var selectedTextColor: UIColor = UIColor.aptNone
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Buildings"
        
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        self.automaticallyAdjustsScrollViewInsets = true 
        
        self.parent!.tabBarItem!.image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
        self.parent!.tabBarItem!.selectedImage = #imageLiteral(resourceName: "PostListSelected").withRenderingMode(.alwaysOriginal)
        
        let date = Date()
        
        let dateString = date.dateString(dateStyle: .long, timeStyle: .none)
        
        print(dateString)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackground()
        switch AppearanceController.shared.selectedCollege {
        case .byu:
//            self.tableView.backgroundColor = UIColor.aptBYU
//            self.tableHeaderView.backgroundColor = UIColor.aptBYU
            self.selectedThemeColor = UIColor.aptBYU
            self.selectedTextColor = UIColor.aptBYU
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
            imageView.image = #imageLiteral(resourceName: "BackgroundViewBlue")
            self.tableView.backgroundView = imageView
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePostBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelectedBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePostBlue").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelectedBlue").withRenderingMode(.alwaysOriginal)
            
        case .uvu:
//            self.tableView.backgroundColor = UIColor.aptUVU
//            self.tableHeaderView.backgroundColor = UIColor.aptUVU
            self.selectedTextColor = UIColor.aptUVU
            self.selectedThemeColor = UIColor.aptUVU
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
            imageView.image = #imageLiteral(resourceName: "BackgroundViewGreen")
            self.tableView.backgroundView = imageView
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePostGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelectedGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePostGreen").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelectedGreen").withRenderingMode(.alwaysOriginal)
        case .none:
//            self.tableView.backgroundColor = UIColor.aptNone
//            self.tableHeaderView.backgroundColor = UIColor.aptNone
            self.selectedThemeColor = UIColor.aptNone
            self.selectedTextColor = UIColor.aptNone
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
            imageView.image = #imageLiteral(resourceName: "BackgroundViewSalmon")
            self.tableView.backgroundView = imageView
            
            self.tabBarController?.tabBar.items?[0].image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].image = #imageLiteral(resourceName: "CreatePost1").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "PostListSelected").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "CreatePost1").withRenderingMode(.alwaysOriginal)
            self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "ProfileSelected").withRenderingMode(.alwaysOriginal)
        }
        
        self.tableView.reloadData()
    }
    
    func setupBackground() {
        
    }
    
    override func viewWillLayoutSubviews() {
        //self.tableView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    var mockApartmentListings = [0, 5, 2, 15, 8, 6, 10, 11]
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return apartments.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if let cell = sender.view?.superview?.superview {
        
        let cell = tableView.cellForRow(at: indexPath) as? ApartmentTableViewCell
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            cell?.leftAccentViewWidthConstraint.constant = cell?.mainSubView.frame.width ?? 60
            self.view.layoutIfNeeded()
        }) { (bool) in
            
            self.performSegue(withIdentifier: "toListingsSegue", sender: cell)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentCell", for: indexPath) as? ApartmentTableViewCell
        
        let name = apartments[indexPath.section].name
        let listingNum = apartments[indexPath.section].listings?.count ?? 0
        
        cell?.leftAccentViewWidthConstraint.constant = 60
        cell?.updateWith(name: name, numberOfListings: listingNum, selectedColor: selectedThemeColor)
        
        //        let separatorView = UIView(frame: CGRect(x: 10, y: 58, width: self.view.frame.width, height: 1))
        //        separatorView.backgroundColor = UIColor.aptGray
        //
        //        print(cell?.frame.height)
        //
        //        if indexPath.row != mockApartmentNames.count - 1 {
        //            cell?.addSubview(separatorView)
        //        }
        
        return cell ?? UITableViewCell()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 5))
        view.backgroundColor = .clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toListingsSegue" {
            if let cell = sender as? ApartmentTableViewCell {
                if let indexPath = self.tableView.indexPath(for: cell) {
                    if let listingsVC = segue.destination as? ListingsTableViewController {
                        listingsVC.apartment = apartments[indexPath.section]
                    }
                }
            }
        }
    }
}
