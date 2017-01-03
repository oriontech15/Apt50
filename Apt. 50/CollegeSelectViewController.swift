//
//  CollegeSelectViewController.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/16/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CollegeSelectViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var bottomView: RoundedVisualEffectView!
    @IBOutlet weak var topView: RoundedVisualEffectView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var okayButtonBottomConstraint: NSLayoutConstraint!
    
    var colleges: [College] {
        var colleges: [College] = []
        for college in College.allValues {
            colleges.append(college)
        }
        
        return colleges
    }
    
    var selectedCollege: College = .none

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        self.bottomView.layer.borderColor = selectedCollege.color.cgColor
        self.bottomView.layer.borderWidth = 0
        self.tableView.contentInset = UIEdgeInsetsMake(130, 0, 130, 0)
        self.okayButton.isEnabled = false
        self.okayButton.layer.cornerRadius = self.okayButton.frame.height / 2
        self.okayButton.backgroundColor = selectedCollege.color
    }
    
    func showOkayButton() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: { [unowned self] in
            
            self.bottomViewConstraint.constant = -125
            self.okayButtonBottomConstraint.constant = 35
            self.view.layoutIfNeeded()
            
            }, completion: { _ in self.okayButton.isEnabled = true })
    }
    
    @IBAction func okayButtonTapped() {
        self.topView.removeFromSuperview()
        AppearanceController.shared.selectedCollege = selectedCollege
        self.dismiss(animated: true, completion: nil)
    }

}

extension CollegeSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeCell", for: indexPath) as? CollegeTableViewCell
        
        let college = colleges[indexPath.row]
        cell?.updateWith(color: college.color, name: college.rawValue)
        cell?.color = college.color
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollege = colleges[indexPath.row]
        okayButton.backgroundColor = selectedCollege.color
        self.bottomView.layer.borderColor = selectedCollege.color.cgColor
        self.bottomView.layer.borderWidth = 1.5
        showOkayButton()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
