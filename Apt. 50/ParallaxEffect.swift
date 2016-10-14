//
//  TRIParallaxEffect.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/8/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import UIKit

protocol TRIParallaxEffectDelegate {
  func keyPathsAndRelativeValuesForViewerOffset(values: [String : AnyObject]?)
}

class TRIParallaxEffect: UIInterpolatingMotionEffect {
  
  var delegate: TRIParallaxEffectDelegate?
  
    override func keyPathsAndRelativeValues(forViewerOffset viewerOffset: UIOffset) -> [String : Any]? {
        let values = super.keyPathsAndRelativeValues(forViewerOffset: viewerOffset)
        if let delegate = self.delegate { delegate.keyPathsAndRelativeValuesForViewerOffset(values: values as [String : AnyObject]?) }
        return values
    }
}
