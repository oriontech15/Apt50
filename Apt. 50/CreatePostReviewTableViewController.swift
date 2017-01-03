//
//  CreatePostReviewTableViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CreatePostReviewTableViewController: UITableViewController, ProgressDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    
    var postedLabel: UILabel!
    var progressView: ProgressView!
    //var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageController.shared.progressDelegate = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        submitButton.backgroundColor = AppearanceController.shared.selectedColor
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as! ReviewPhotosTableViewCell
            let kitchen = PostController.shared.tempPhotos[.kitchen]
            let bathRoom = PostController.shared.tempPhotos[.bathRoom]
            let bedRoom = PostController.shared.tempPhotos[.bedRoom]
            let livingRoom = PostController.shared.tempPhotos[.livingRoom]
            
            cell.update(with: kitchen, bathroom: bathRoom, bedRoom: bedRoom, livingRoom: livingRoom)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentCell", for: indexPath) as! ReviewApartmentTableViewCell
            if let apartment = PostController.shared.tempPost?.apartment {
                cell.update(with: apartment.name)
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactInfoCell", for: indexPath) as! ReviewContactInfoTableViewCell
            if let contactInfo = PostController.shared.tempPost?.contactInfo {
                cell.update(with: contactInfo.contactName, phone: contactInfo.phoneNumber, email: contactInfo.email)
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentInfoCell", for: indexPath) as! ReviewApartmentInfoTableViewCell
            
            if let post = PostController.shared.tempPost {
                cell.update(apartmentType: post.apartmentType, roomType: post.roomType, laundryType: post.laundryType, tvType: post.tvType, internetType: post.internetType, parkingType: post.parkingType, montlyRent: post.rentPrice.currency)
            }
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 160
        case 1:
            return 115
        case 2:
            return 145
        case 3:
            return 255
        default:
            return 45
        }
    }
    
    func changeLabelUpdating() {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.postedLabel.text = "Uploading Images..."
            }
        }
    }
    
    func changeLabelUpdated() {
        
        DispatchQueue.main.async {
            self.progressView.progress = self.progressView.progress + 25
            
            UIView.animate(withDuration: 0.2) {
                if self.progressView.progress == 100 {
                    self.postedLabel.text = "Posted!"
                }
            }
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let apartment = PostController.shared.tempPost!.apartment
        //let contactName = PostController.shared.tempPost!.contactInfo!.contactName
        let apartmentType = PostController.shared.tempPost!.apartmentType
        let roomType = PostController.shared.tempPost!.roomType
        let laundryType = PostController.shared.tempPost!.laundryType
        let tvType = PostController.shared.tempPost!.tvType
        let internetType = PostController.shared.tempPost!.internetType
        let parkingType = PostController.shared.tempPost!.parkingType
        let rentPrice = PostController.shared.tempPost!.rentPrice
        
        let contactInfo = ContactInfoController.shared.getContactInfo()
        
        postedLabel = UILabel(frame: CGRect(x: self.view.center.x - 100, y: self.view.center.y - 55, width: 200, height: 30))
        postedLabel.text = ""
        postedLabel.textAlignment = .center
        postedLabel.textColor = AppearanceController.shared.selectedColor
        postedLabel.font = UIFont(name: "Avenir-Medium", size: 20)
        //        imageNumber = 5
        
        progressView = ProgressView(startingPoint: CGPoint(x: 20, y: self.view.center.y + 40), width: self.view.frame.width, bgColor: AppearanceController.shared.selectedColor, title: "")
        progressView.progress = 0
        
        let wheel = UIActivityIndicatorView(frame: CGRect(x: self.view.center.x - 15, y: self.view.center.y - 15, width: 30, height: 30))
        wheel.color = AppearanceController.shared.selectedColor
        wheel.hidesWhenStopped = true
        wheel.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurLoadingView = UIVisualEffectView(effect: blurEffect)
        blurLoadingView.frame = UIScreen.main.bounds
        blurLoadingView.alpha = 0.0
        blurLoadingView.addSubview(wheel)
        blurLoadingView.addSubview(postedLabel)
        blurLoadingView.addSubview(progressView)
        self.navigationController?.view.addSubview(blurLoadingView)
        self.navigationController?.view.bringSubview(toFront: blurLoadingView)
        
        UIView.animate(withDuration: 0.4) {
            blurLoadingView.alpha = 1.0
        }
        
        wheel.startAnimating()
        
        var photos: [String : UIImage] = [:]
        for (key, photo) in PostController.shared.tempPhotos {
            photos.updateValue(photo, forKey: key.rawValue)
        }
        
        
        let queue = DispatchQueue(label: "posting")
        queue.async {
            if let apartment = apartment {
                PostController.shared.createPost(apartment: apartment, contactInfo: contactInfo, roomType: roomType, apartmentType: apartmentType, tvType: tvType, internetType: internetType, laundryType: laundryType, parkingType: parkingType, rentPrice: rentPrice, photos: photos, completion: {(success) in
                    
                    if success {
                        
                        DispatchQueue.main.async {
                            wheel.stopAnimating()
                        }
                        
                        let deadlineTime = DispatchTime.now() + 0.8
                        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                            //self.changeLabelUpdated()
                            PostController.shared.tempPhotos = [:]
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                })
            }
        }
    }
}
