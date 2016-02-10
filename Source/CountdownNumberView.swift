//
//  CountdownNumberView.swift
//  Countdown
//
//  Created by Daniel Nilsson on 02/11/15.
//  Copyright © 2015 Daniel Nilsson. All rights reserved.
//

import UIKit

@IBDesignable public class CountdownNumberView: UIView {

    var label: UILabel!
    private var clipView: UIView!
    
    @IBInspectable var text: String? {
        didSet {
            // Only change when it's a new text
            if label.text == text {
                return
            }
            
            // Don't animate the first time
            if label.text != nil {
                label.slideInFromTop()
            }
            
            label.text = text
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    public override func drawRect(rect: CGRect) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // Color Declarations
        let gradientColor1 = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1.000)
        let gradientColor2 = UIColor(red: 0.153, green: 0.153, blue: 0.153, alpha: 1.000)
        let gradientColor3 = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000)
        let gradientColor4 = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1.000)
        
        // Gradient Declarations
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor3.CGColor, gradientColor2.CGColor, gradientColor4.CGColor, gradientColor1.CGColor], [0, 0.49, 0.51, 1])!
        
        // Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 3)
        shadow.shadowBlurRadius = 3
        
        // Rectangle Drawing
        let bezierFrame = CGRect(x: 3, y: 0, width: bounds.size.width - 6, height: bounds.size.height - 3)
        let rectanglePath = UIBezierPath(roundedRect: bezierFrame, cornerRadius: 5)
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        CGContextBeginTransparencyLayer(context, nil)
        rectanglePath.addClip()
        let gradientPointStart = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMinY(bounds))
        let gradientPointEnd = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMaxY(bounds))
        CGContextDrawLinearGradient(context, gradient, gradientPointStart, gradientPointEnd, CGGradientDrawingOptions())
        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }
    
    private func createSubviews() {
        clipView = UIView()
        clipView.clipsToBounds = true
        addSubview(clipView)
        
        label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        clipView.addSubview(label)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clearColor()
        
        let labelFrame = CGRectMake(0, 1, bounds.size.width, bounds.size.height - 6)
        label.frame = labelFrame
        clipView.frame = labelFrame
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        text = "0"
    }
}
