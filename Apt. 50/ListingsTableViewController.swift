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
    
    var loadingIndicator: UIActivityIndicatorView!
    
    var firstLoad: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkListings(completion: @escaping (_ hasListings: Bool) -> Void) {
        if let apartment = apartment {
            if apartment.listings.count == 0 {
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
                
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.removeFromSuperview()
            } else {
                PostController.shared.getPosts(forApartment: apartment, completion: { (posts) in
                    if let posts = posts {
                        self.listings = posts
                        
                        let queue = DispatchQueue(label: "getImages")
                        let group = DispatchGroup()
                        
                        if let listings = self.listings {
                            for post in listings {
                                group.enter()
                                queue.async {
                                    if let imageDict = post.photoURLs, let key = imageDict.keys.first, let imageURL = imageDict[key] {
                                        ImageController.shared.imageForUrl(urlString: imageURL, completion: { (image) in
                                            if let image = image {
                                                post.photos.append(image)
                                                group.leave()
                                            }
                                        })
                                    }
                                }
                            }
                            
                            group.notify(queue: queue, execute: {
                                completion(true)
                            })
                        } else {
                            completion(false)
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func backButtonTapped() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        self.tableView.reloadData()
        
        if firstLoad {
            
            self.loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 25, y: UIScreen.main.bounds.height / 2 - 25, width: 50, height: 50))
            self.loadingIndicator.transform = CGAffineTransform(scaleX: 1.65, y: 1.65)
            self.loadingIndicator.color = AppearanceController.shared.selectedColor
            self.loadingIndicator.hidesWhenStopped = true
            self.loadingIndicator.startAnimating()
            
            self.navigationController?.view.addSubview(self.loadingIndicator)
            
            checkListings { hasListings in
                
                if hasListings {
                    DispatchQueue.main.async {
                        self.animateTable()
                    }
                }
            }
            
            self.firstLoad = false
        }
    }
    
    func animateTable() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.removeFromSuperview()
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
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
        
        if let listings = listings, let cell = cell {
            let post = listings[indexPath.row]
            let price = post.rentPrice
            if let image = post.photos[0].resizeImage(size: cell.bounds.size) {
                
                cell.updateWith(image: image, color: AppearanceController.shared.selectedColor, price: price.currency)
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPostDetail", sender: nil)
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
        //DropInCellAnimator.animate(cell: cell)
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
        
        if segue.identifier == "toPostDetail" {
            //            if let vc = segue.destination as? PostDetailViewController {
            //                print(vc)
            //            }
        }
    }
    
}
