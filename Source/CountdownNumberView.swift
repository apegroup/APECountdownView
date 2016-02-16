// CountdownNumberView.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 apegroup
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/**
A view with a number and a block.
*/
@IBDesignable class CountdownNumberView: UIView {

    /**
     Label of the number. Do not change this text instead use text property of CountdownNumberView.
    */
    var label: UILabel!
    
    /**
     Color of the first gradient.
    */
    var gradientColor1 = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000)
    
    /**
     Color of the second gradient.
    */
    var gradientColor2 = UIColor(red: 0.153, green: 0.153, blue: 0.153, alpha: 1.000)
    
    /**
     Color of the third gradient.
    */
    var gradientColor3 = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1.000)
    
    /**
     Color of the fourth gradient.
    */
    var gradientColor4 = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1.000)
    
    private var clipView: UIView!
    
    /**
     The number in the view.
    */
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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
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
    
    override func drawRect(rect: CGRect) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // Gradient Declarations
        let gradientColors = [gradientColor1.CGColor, gradientColor2.CGColor, gradientColor3.CGColor, gradientColor4.CGColor]
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientColors, [0, 0.49, 0.51, 1])!
        
        // Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 3)
        shadow.shadowBlurRadius = 3
        
        // Rectangle Drawing
        let bezierFrame = CGRect(x: 3, y: 0, width: bounds.size.width - 6, height: bounds.size.height - 6)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clearColor()
        
        let labelFrame = CGRectMake(0, 1, bounds.size.width, bounds.size.height - 9)
        label.frame = labelFrame
        clipView.frame = labelFrame
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        text = "0"
    }
}
