//
//  ListingsTableViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ListingsTableViewController: UITableViewController {
    
    var apartment: Apartment?
    var listings: [Post]?
    
    var selectedThemeColor: UIColor = .aptNone

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let apartment = apartment {
            self.title = apartment.name

        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func checkListings() {
        if let apartment = apartment {
            let listingsForApartment = PostController.shared.getPostsForApartment(apartment: apartment)
            if listingsForApartment?.count == 0 {
                let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
                let noListingsLabel = CustomLabel(frame: CGRect(x: 50, y: self.tableView.frame.height / 2 - 100, width: self.tableView.frame.width - 100, height: 200))
                noListingsLabel.backgroundColor = selectedThemeColor
                noListingsLabel.textColor = .white
                noListingsLabel.cornerRadius = 25
                noListingsLabel.text = "Sorry... \n\nNo listings.\nCheck back later."
                noListingsLabel.textAlignment = .center
                noListingsLabel.numberOfLines = 0
                noListingsLabel.font = UIFont(name: Fonts.HelveticaNeueBold.rawValue, size: 20)
                backgroundView.addSubview(noListingsLabel)
                    
                self.tableView.backgroundView = backgroundView
            } else {
                listings = listingsForApartment
            }
        }
    }
    
    @IBAction func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func setupView() {
        
        switch AppearanceController.shared.selectedCollege {
        case .byu:
            self.selectedThemeColor = .aptBYU
            self.navigationController?.navigationBar.barTintColor = UIColor.aptBYU
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        case .uvu:
            self.selectedThemeColor = .aptUVU
            self.navigationController?.navigationBar.barTintColor = UIColor.aptUVU
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        case .none:
            self.selectedThemeColor = .aptNone
            self.navigationController?.navigationBar.barTintColor = UIColor.aptNone
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
        
        checkListings()
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //return apartment?.listings?.count ?? 0
        return listings?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as? PostTableViewCell

        let image = ImageController.shared.mockPhotos()[indexPath.row]
        if let apartment = apartment, let listings = listings {
            cell?.updateWith(image: image, color: selectedThemeColor, price: "240")
        }
        
        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
