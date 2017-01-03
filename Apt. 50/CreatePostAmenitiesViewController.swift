//
//  CreatePostAmenitiesViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 10/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostAmenitiesTableViewController: UITableViewController, TextUpdatedDelegate {

    @IBOutlet weak var toPhotosSectionButton: UIButton!
    @IBOutlet weak var apartmentTypeCell: ApartmentTypeTableViewCell!
    @IBOutlet weak var roomTypeCell: RoomTypeTableViewCell!
    @IBOutlet weak var laundryTypeCell: LaundryTypeTableViewCell!
    @IBOutlet weak var tvTypeCell: TVTableViewCell!
    @IBOutlet weak var internetTypeCell: InternetTableViewCell!
    @IBOutlet weak var parkingTypeCell: ParkingTableViewCell!
    @IBOutlet weak var rentCell: RentPriceTableViewCell!
    
    @IBOutlet weak var photosButtonCenterY: NSLayoutConstraint!
    
    var confirmed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rentCell.textUpdatedDelegate = self

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        toPhotosSectionButton.backgroundColor = AppearanceController.shared.selectedColor
        toPhotosSectionButton.layer.cornerRadius = toPhotosSectionButton.frame.height / 2
    }
    
    func showPhotosButton() {
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            
                self.photosButtonCenterY.constant = 0
                self.tableView.tableFooterView?.layoutIfNeeded()
            }, completion: { _ in
                
                self.tableView.scrollRectToVisible(self.tableView.convert((self.tableView.tableFooterView?.bounds)!, from: self.tableView.tableFooterView), animated: true)
        })
    }
    
    @IBAction func toPhotosButtonTapped(_ sender: Any) {
        let apartmentType = apartmentTypeCell.apartmentTypeSegmentedControl.items[apartmentTypeCell.apartmentTypeSegmentedControl.selectedIndex]
        let roomType = roomTypeCell.roomTypeSegmentedControl.items[roomTypeCell.roomTypeSegmentedControl.selectedIndex]
        let laundryType = laundryTypeCell.laundryTypeSegmentedControl.items[laundryTypeCell.laundryTypeSegmentedControl.selectedIndex]
        let tvType: TVType = tvTypeCell.toggleButton.myIsSelected ? .included : .notIncluded
        let internetType: InternetType = internetTypeCell.toggleButton.myIsSelected ? .included : .notIncluded
        let parkingType: ParkingType = parkingTypeCell.toggleButton.myIsSelected ? .included : .notIncluded
        
        let post = PostController.shared.tempPost
        post?.apartmentType = apartmentType
        post?.roomType = roomType
        post?.laundryType = laundryType
        post?.tvType = tvType.rawValue
        post?.internetType = internetType.rawValue
        post?.parkingType = parkingType.rawValue
        
        if let rentString = rentCell.rentTextField.text, rentCell.rentTextField.text != "", let monthlyRent = Double(rentString) {
            post?.rentPrice = monthlyRent
        }

        self.performSegue(withIdentifier: "toPhotosSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
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
