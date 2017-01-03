//
//  CreatePostImagesTableViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostImagesTableViewController: UITableViewController {
    
    @IBOutlet weak var kitchenPhotoCell: CreatePostImageTableViewCell!
    @IBOutlet weak var livingRoomPhotoCell: CreatePostImageTableViewCell!
    @IBOutlet weak var bathroomPhotoCell: CreatePostImageTableViewCell!
    @IBOutlet weak var bedroomPhotoCell: CreatePostImageTableViewCell!
    @IBOutlet weak var toReviewPageButton: CustomRoundedButton!

    @IBOutlet weak var toReviewButtonCenterY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        toReviewPageButton.backgroundColor = AppearanceController.shared.selectedColor
        toReviewPageButton.layer.cornerRadius = toReviewPageButton.frame.height / 2
    }
    
    func checkPhotos() {

        if PostController.shared.tempPhotos.count == 4 {

            //[self.tableView scrollRectToVisible:[self.tableView convertRect:self.tableView.tableFooterView.bounds fromView:self.tableView.tableFooterView] animated:YES];

            self.tableView.scrollRectToVisible(self.tableView.convert((self.tableView.tableFooterView?.bounds)!, from: self.tableView.tableFooterView), animated: true)
            UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
                
                self.toReviewButtonCenterY.constant = 0
                self.tableView.tableFooterView?.layoutIfNeeded()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tempPhotos = PostController.shared.tempPhotos
        if tempPhotos.count != 0 {
            for (key, value) in tempPhotos {
                switch key {
                case .kitchen:
                    kitchenPhotoCell.photoImageView.image = value.resizeImage(size: livingRoomPhotoCell.photoImageView.frame.size)
                    kitchenPhotoCell.photoButton.backgroundColor = .clear
                    kitchenPhotoCell.shrink()
                case .bedRoom:
                    bedroomPhotoCell.photoImageView.image = value.resizeImage(size: livingRoomPhotoCell.photoImageView.frame.size)
                    bedroomPhotoCell.photoButton.backgroundColor = .clear
                    bedroomPhotoCell.shrink()
                case .bathRoom:
                    bathroomPhotoCell.photoImageView.image = value.resizeImage(size: livingRoomPhotoCell.photoImageView.frame.size)
                    bathroomPhotoCell.photoButton.backgroundColor = .clear
                    bathroomPhotoCell.shrink()
                case .livingRoom:
                    livingRoomPhotoCell.photoImageView.image = value.resizeImage(size: livingRoomPhotoCell.photoImageView.frame.size)
                    livingRoomPhotoCell.photoButton.backgroundColor = .clear
                    livingRoomPhotoCell.shrink()
                default:
                    break
                }
                
                self.tableView.reloadData()
            }
        } // NEED TO CLEAR THE TEMP ARRAY ONCE THE POST HAS BEEN SUBMITTED!!!!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let deadlineTime = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [unowned self] in
            self.checkPhotos()
        }
        
    }
    
    @IBAction func unwindToPhotos(segue: UIStoryboardSegue) {}
    
    
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
