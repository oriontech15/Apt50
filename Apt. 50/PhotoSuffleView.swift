//
//  PhotoSuffleTableViewCell.swift
//  Apt. 50
//
//  Created by Justin Smith on 12/9/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PhotoSuffleView: UIView, UIGestureRecognizerDelegate {
    
    var imageViews: [UIImageView] = []
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    var exitFrame: CGRect!
    var previewingFrame: CGRect!
    var nextFrame: CGRect!
    
    var currentIndex = 0
    var nextIndex = 1
    var lastIndex = 0
    
    var previewingImageViewVisible: Bool = true
    
    var images: [UIImage] = []
    var titles: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var images: [UIImage] = []
        
        for (key, value) in PostController.shared.tempPhotos {
            titles.append(key.rawValue)
            images.append(value)
        }
        
        setupCell(images: images)
    }
    
    func setupCell(images: [UIImage]) {
        self.images = images
        self.isUserInteractionEnabled = true
        
        self.imageTitleLabel.layer.cornerRadius = self.imageTitleLabel.frame.height / 2
        self.imageTitleLabel.layer.masksToBounds = true
        
        self.pageController.numberOfPages = images.count
        self.pageController.currentPage = currentIndex
        self.pageController.pageIndicatorTintColor = AppearanceController.shared.selectedColor
        
        print("Image count: \(images.count)")
        previewingFrame = CGRect(x: 4, y: 37, width: UIScreen.main.bounds.width - 8, height: 250 - 45)
        nextFrame = CGRect(x: UIScreen.main.bounds.width + 20, y: 4, width: UIScreen.main.bounds.width, height: 250 - 66)
        exitFrame = CGRect(x: -UIScreen.main.bounds.width - 20, y: 4, width: UIScreen.main.bounds.width, height: 250 - 66)
        
        for (index, image) in images.enumerated() {
            let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImage(sender:)))
            leftGesture.direction = .left
            leftGesture.delegate = self
            let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImage(sender:)))
            rightGesture.direction = .right
            rightGesture.delegate = self
            
            let imageView: UIImageView!
            
            if index == 0 {
                imageView = UIImageView(frame: previewingFrame)
            } else {
                imageView = UIImageView(frame: nextFrame)
            }
            
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
            imageView.addGestureRecognizer(leftGesture)
            imageView.addGestureRecognizer(rightGesture)
            imageView.isUserInteractionEnabled = true
            imageView.image = image.resizeImage(size: self.frame.size)
            self.imageViews.append(imageView)
            self.addSubview(imageView)
        }
        
        self.bringSubview(toFront: self.pageController)

    }
    
    func updateWith(images: [UIImage]) {
        setupCell(images: images)
    }
    
    @IBAction func pageControllerValueChanged(sender: UIPageControl) {
        if sender.currentPage == currentIndex - 1 {
            
            if currentIndex != 0 {
                
                self.currentIndex = self.currentIndex - 1
                self.nextIndex = self.nextIndex - 1
                
                print("current: \(currentIndex)")
                print("next: \(nextIndex)")
                
                self.imageViews[self.currentIndex].alpha = 1.0
                
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                    self.imageViews[self.currentIndex].frame = self.previewingFrame
                    self.imageViews[self.nextIndex].frame = self.nextFrame
                    
                }, completion: { (_) in
                    
                    self.pageController.currentPage = self.currentIndex
                    
                    self.imageTitleLabel.text = self.titles[self.currentIndex]

                    self.imageViews[self.currentIndex + 1].alpha = 0.0

                    //self.previewingImageViewVisible = !self.previewingImageViewVisible
                })
            }
        } else if sender.currentPage == currentIndex + 1 {
            if nextIndex <= images.count - 1 {
                
                print("current: \(currentIndex)")
                print("next: \(nextIndex)")
                
                self.imageViews[self.nextIndex].alpha = 1.0
                
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                    self.imageViews[self.currentIndex].frame = self.exitFrame
                    self.imageViews[self.nextIndex].frame = self.previewingFrame
                    
                }, completion: { (_) in
                    
                    self.currentIndex = self.currentIndex + 1
                    self.nextIndex = self.nextIndex + 1
                    
                    self.imageTitleLabel.text = self.titles[self.currentIndex]

                    self.pageController.currentPage = self.currentIndex
                    
                    self.imageViews[self.currentIndex - 1].alpha = 0.0
                    //self.previewingImageViewVisible = !self.previewingImageViewVisible
                })
            }
        }
    }
    
    func changeImage(sender: UISwipeGestureRecognizer) {
        print("recognized")
        if sender.direction == .right {
            if currentIndex != 0 {
                
                self.currentIndex = self.currentIndex - 1
                self.nextIndex = self.nextIndex - 1
                
                print("current: \(currentIndex)")
                print("next: \(nextIndex)")
                
                self.imageViews[self.currentIndex].alpha = 1.0
                
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                    self.imageViews[self.currentIndex].frame = self.previewingFrame
                    self.imageViews[self.nextIndex].frame = self.nextFrame
                    
                }, completion: { (_) in
                    
                    self.pageController.currentPage = self.currentIndex

                    self.imageTitleLabel.text = self.titles[self.currentIndex]

                    self.imageViews[self.currentIndex + 1].alpha = 0.0

                    //self.previewingImageViewVisible = !self.previewingImageViewVisible
                })
            }
        } else if sender.direction == .left {
            if nextIndex <= images.count - 1 {
                
                print("current: \(currentIndex)")
                print("next: \(nextIndex)")
                
                self.imageViews[self.nextIndex].alpha = 1.0
                
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                    self.imageViews[self.currentIndex].frame = self.exitFrame
                    self.imageViews[self.nextIndex].frame = self.previewingFrame
                    
                }, completion: { (_) in
                    
                    self.currentIndex = self.currentIndex + 1
                    self.nextIndex = self.nextIndex + 1
                    
                    self.imageTitleLabel.text = self.titles[self.currentIndex]

                    self.imageViews[self.currentIndex - 1].alpha = 0.0

                    self.pageController.currentPage = self.currentIndex
                    //self.previewingImageViewVisible = !self.previewingImageViewVisible
                })
            }
        }
    }
}
