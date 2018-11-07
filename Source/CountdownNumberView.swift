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
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        clipView.addSubview(label)
    }
    
    override func draw(_ rect: CGRect) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        // Gradient Declarations
        let gradientColors: [CGColor] = [gradientColor1.cgColor, gradientColor2.cgColor, gradientColor3.cgColor, gradientColor4.cgColor]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: [0, 0.49, 0.51, 1])!
        
        // Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 3)
        shadow.shadowBlurRadius = 3
        
        // Rectangle Drawing
        let bezierFrame = CGRect(x: 3, y: 0, width: bounds.size.width - 6, height: bounds.size.height - 6)
        let rectanglePath = UIBezierPath(roundedRect: bezierFrame, cornerRadius: 5)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        rectanglePath.addClip()
        let gradientPointStart = CGPoint(x: bounds.midX, y: bounds.minY)
        let gradientPointEnd = CGPoint(x: bounds.midX, y: bounds.maxY)
        context.drawLinearGradient(gradient, start: gradientPointStart, end: gradientPointEnd, options: CGGradientDrawingOptions())
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear

        let labelFrame = CGRect(x: 0, y: 1, width: bounds.size.width, height: bounds.size.height - 9)
        label.frame = labelFrame
        clipView.frame = labelFrame
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        text = "0"
    }
}
