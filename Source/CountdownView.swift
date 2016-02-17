// CountdownView.swift
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

import RxSwift

/**
A view with a countdown.
*/
@IBDesignable public class CountdownView: UIView {

    @IBOutlet weak var countdownNumberViewDay1: CountdownNumberView!
    @IBOutlet weak var countdownNumberViewDay2: CountdownNumberView!
    
    @IBOutlet weak var countdownNumberViewHour1: CountdownNumberView!
    @IBOutlet weak var countdownNumberViewHour2: CountdownNumberView!
    
    @IBOutlet weak var countdownNumberViewMin1: CountdownNumberView!
    @IBOutlet weak var countdownNumberViewMin2: CountdownNumberView!
    
    @IBOutlet weak var countdownNumberViewSec1: CountdownNumberView!
    @IBOutlet weak var countdownNumberViewSec2: CountdownNumberView!
    
    @IBOutlet var countdownNumberViews: [CountdownNumberView]!
    
    @IBOutlet var countdownSizeWidthConstraints: [NSLayoutConstraint]!
    @IBOutlet var countdownSizeHeightConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var countdownGroupConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var countdownSectionConstraints: [NSLayoutConstraint]!
    @IBOutlet var countdownCenterConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var countdownTitleLabels: [UILabel]!
    
    /**
     Size of each block.
    */
    @IBInspectable public var size: CGSize = CGSize(width: 40, height: 30) {
        didSet {
            for sizeWidthConstraint in countdownSizeWidthConstraints {
                sizeWidthConstraint.constant = size.width
            }
            
            for sizeHeightConstraint in countdownSizeHeightConstraints {
                sizeHeightConstraint.constant = size.height
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Space between each related block. eg. space between day1 and day2.
    */
    @IBInspectable public var groupSpace: CGFloat = -3 {
        didSet {
            for groupConstraint in countdownGroupConstraints {
                groupConstraint.constant = groupSpace
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Space between each section block. eg. space between day2 and hour1.
    */
    @IBInspectable public var sectionSpace: CGFloat = 3 {
        didSet {
            for sectionConstraint in countdownSectionConstraints {
                sectionConstraint.constant = sectionSpace
            }
            
            for centerConstraint in countdownCenterConstraints {
                centerConstraint.constant = sectionSpace / 2
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Color of the first gradient. Top of the blocks.
    */
    @IBInspectable public var gradientColor1: UIColor = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor1 = gradientColor1
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Color of the second gradient. Middle of the blocks.
    */
    @IBInspectable public var gradientColor2: UIColor = UIColor(red: 0.153, green: 0.153, blue: 0.153, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor2 = gradientColor2
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Color of the third gradient. Middle of the blocks.
    */
    @IBInspectable public var gradientColor3: UIColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor3 = gradientColor3
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Color of the fourth gradient. Bottom of the blocks.
    */
    @IBInspectable public var gradientColor4: UIColor = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor4 = gradientColor4
            }
            
            layoutIfNeeded()
        }
    }
    
    private static let defaultBlockFont = UIFont.boldSystemFontOfSize(16)
    
    /**
     Font name of each block.
     Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    */
    @available(*, unavailable, message = "This property is reserved for Interface Builder. Use 'blockFont' instead.")
    @IBInspectable var blockFontName: String = defaultBlockFont.fontName {
        willSet(newValue) {
            let font = UIFont(name: newValue, size: blockFont.pointSize)
            if font == nil {
                fatalError("Not a valid font name.")
            } else {
                blockFont = font!
            }
        }
    }
    
    /**
     Font size of each block.
     Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    */
    @available(*, unavailable, message = "This property is reserved for Interface Builder. Use 'blockFont' instead.")
    @IBInspectable var blockFontSize: CGFloat = defaultBlockFont.pointSize {
        willSet(newValue) {
            let font = blockFont.fontWithSize(newValue)
            blockFont = font
        }
    }
    
    /**
     Font color of each block.
    */
    @IBInspectable public var blockFontColor: UIColor = UIColor.whiteColor() {
        didSet {
            for numberView in countdownNumberViews {
                numberView.label.textColor = blockFontColor
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Font of each block.
    */
    public var blockFont = defaultBlockFont {
        didSet {
            for numberView in countdownNumberViews {
                numberView.label.font = blockFont
            }
            
            layoutIfNeeded()
        }
    }
    
    private static let defaultTitleFont = UIFont.systemFontOfSize(10)
    
    /**
     Font name of each title.
     Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    */
    @available(*, unavailable, message = "This property is reserved for Interface Builder. Use 'titleFont' instead.")
    @IBInspectable var titleFontName: String = defaultTitleFont.fontName {
        willSet(newValue) {
            let font = UIFont(name: newValue, size: titleFont.pointSize)
            if font == nil {
                fatalError("Not a valid font name.")
            } else {
                blockFont = font!
            }
        }
    }
    
    /**
     Font size of each title.
     Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    */
    @available(*, unavailable, message = "This property is reserved for Interface Builder. Use 'titleFont' instead.")
    @IBInspectable var titleFontSize: CGFloat = defaultTitleFont.pointSize {
        willSet(newValue) {
            let font = titleFont.fontWithSize(newValue)
            titleFont = font
        }
    }
    
    /**
     Font color of each title.
    */
    @IBInspectable public var titleFontColor: UIColor = UIColor.blackColor() {
        didSet {
            for titleLabel in countdownTitleLabels {
                titleLabel.textColor = titleFontColor
            }
            
            layoutIfNeeded()
        }
    }
    
    /**
     Font of each title.
    */
    public var titleFont = defaultTitleFont {
        didSet {
            for titleLabel in countdownTitleLabels {
                titleLabel.font = titleFont
            }
            
            layoutIfNeeded()
        }
    }
    
    private var contentView: UIView!
    private let countdownViewModel = CountdownViewModel()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    /**
     Starts the countdown!
     
     - parameter endDate: When the countdown should end.
     - parameter onCompleted: Triggers when countdown is completed.
    */
    public func startCountdown(endDate: NSDate, onCompleted: (() -> Void)? = nil) {
        countdownViewModel.observeCountdown(endDate)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] timeLeft in
                self?.countdownNumberViewDay1.text = timeLeft.day1
                self?.countdownNumberViewDay2.text = timeLeft.day2
                
                self?.countdownNumberViewHour1.text = timeLeft.hour1
                self?.countdownNumberViewHour2.text = timeLeft.hour2
                
                self?.countdownNumberViewMin1.text = timeLeft.min1
                self?.countdownNumberViewMin2.text = timeLeft.min2
                
                self?.countdownNumberViewSec1.text = timeLeft.sec1
                self?.countdownNumberViewSec2.text = timeLeft.sec2
                }, onCompleted: onCompleted)
            .addDisposableTo(disposeBag)
    }
    
    /**
     Setup xib.
    */
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(contentView)
    }
    
    /**
     Load view from nib file.
    */
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CountdownView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    /**
     Prepare for interface builder.
    */
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        for view in contentView.subviews {
            view.prepareForInterfaceBuilder()
        }
    }
}
