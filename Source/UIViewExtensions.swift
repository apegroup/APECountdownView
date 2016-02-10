//
//  UIViewExtensions.swift
//  Countdown
//
//  Created by Daniel Nilsson on 06/11/15.
//  Copyright © 2015 Daniel Nilsson. All rights reserved.
//

import UIKit

extension UIView {
    func slideInFromTop(duration: NSTimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        let slideInFromTopTransition = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            slideInFromTopTransition.delegate = delegate
        }
        
        slideInFromTopTransition.type = kCATransitionPush
        slideInFromTopTransition.subtype = kCATransitionFromTop
        slideInFromTopTransition.duration = duration
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromTopTransition.fillMode = kCAFillModeRemoved
        
        self.layer.addAnimation(slideInFromTopTransition, forKey: "slideInFromTopTransition")
    }
}
