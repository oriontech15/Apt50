//
//  PostListTableViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ApartmentListTableViewController: UITableViewController {
    
    var apartments: [Apartment] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    var selectedThemeColor: UIColor = UIColor.aptNone
    var selectedTextColor: UIColor = UIColor.aptNone
    
    var alreadyAnimated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateApartments), name: notificationApartmentsUpdated, object: nil)
        self.navigationItem.title = "Buildings"
        
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.parent!.tabBarItem!.image = #imageLiteral(resourceName: "PostList").withRenderingMode(.alwaysOriginal)
        self.parent!.tabBarItem!.selectedImage = #imageLiteral(resourceName: "PostListSelected").withRenderingMode(.alwaysOriginal)
        
        let date = Date()
        
        let dateString = date.dateString(dateStyle: .long, timeStyle: .none)
        
        print(dateString)
        
        checkLogin()
    }
    
    func checkLogin() {
        if UserController.shared.user == nil {
            
            self.performSegue(withIdentifier: "toLoginSegue", sender: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedCollege = AppearanceController.shared.selectedCollege
        
        self.selectedTextColor = selectedCollege.color
        self.selectedThemeColor = selectedCollege.color
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        imageView.image = selectedCollege.backgroundImage
        self.tableView.backgroundView = imageView
        
        self.tabBarController?.tabBar.items?[0].image = selectedCollege.unselectedImages.postList.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].image = selectedCollege.unselectedImages.createPost.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].image = selectedCollege.unselectedImages.profile.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[0].selectedImage = selectedCollege.postListImage.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].selectedImage = selectedCollege.createImage.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].selectedImage = selectedCollege.profileImage.withRenderingMode(.alwaysOriginal)
        
        self.tableView.reloadData()
        
        if !alreadyAnimated {
            ApartmentController.shared.getApartments { (apartments) in
                if let apartments = apartments {
                    let sortedApartments = apartments.sorted(by: ({ $0.name.rawValue < $1.name.rawValue }))
                    ApartmentController.shared.apartments = sortedApartments
                    self.updateApartments()
                    self.animateCells()
                    self.alreadyAnimated = true
                }
            }
        }
    }
    
    var index = 0
    
    func animateCells() {
        
        self.tableView.reloadData()
        
        let cells = self.tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableHeight)
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(self.index + 1), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            self.index = self.index + 1
        }
    }
    
    func updateApartments() {
        self.apartments = ApartmentController.shared.apartments
    }
    
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
        
        if let cell = tableView.cellForRow(at: indexPath) as? ApartmentTableViewCell {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: [], animations: { _ in
                
                cell.leftAccentView.frame = CGRect(x: 5, y: 5, width: cell.leftAccentView.frame.width - 10, height: cell.leftAccentView.frame.height - 10)
                cell.leftAccentView.layer.cornerRadius = cell.leftAccentView.frame.height / 2
            }, completion: {_ in
                cell.reset()
                self.performSegue(withIdentifier: "toListingsSegue", sender: cell)
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentCell", for: indexPath) as? ApartmentTableViewCell
        
        let name = apartments[indexPath.section].name
        let listingNum = apartments[indexPath.section].listings.count
        
        cell?.updateWith(name: name.rawValue, numberOfListings: listingNum, selectedColor: selectedThemeColor)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
