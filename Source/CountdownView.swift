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
    
    @IBInspectable public var groupSpace: CGFloat = -3 {
        didSet {
            for groupConstraint in countdownGroupConstraints {
                groupConstraint.constant = groupSpace
            }
            
            layoutIfNeeded()
        }
    }
    
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
    
    @IBInspectable public var gradientColor1: UIColor = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor1 = gradientColor1
            }
            
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var gradientColor2: UIColor = UIColor(red: 0.153, green: 0.153, blue: 0.153, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor2 = gradientColor2
            }
            
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var gradientColor3: UIColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor3 = gradientColor3
            }
            
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var gradientColor4: UIColor = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1.000) {
        didSet {
            for numberView in countdownNumberViews {
                numberView.gradientColor4 = gradientColor4
            }
            
            layoutIfNeeded()
        }
    }
    
    private static let defaultBlockFont = UIFont.boldSystemFontOfSize(16)
    
    // Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    @IBInspectable var blockFontName: String = defaultBlockFont.fontName {
        didSet {
            let font = UIFont(name: blockFontName, size: blockFontSize)
            blockFont = font!
        }
    }
    
    // Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    @IBInspectable var blockFontSize: CGFloat = defaultBlockFont.pointSize {
        didSet {
            let font = blockFont.fontWithSize(blockFontSize)
            blockFont = font
        }
    }
    
    public var blockFont = defaultBlockFont {
        didSet {
            for numberView in countdownNumberViews {
                numberView.label.font = blockFont
            }
            
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var blockFontColor: UIColor = UIColor.whiteColor() {
        didSet {
            for numberView in countdownNumberViews {
                numberView.label.textColor = blockFontColor
            }
            
            layoutIfNeeded()
        }
    }
    
    private static let defaultTitleFont = UIFont.systemFontOfSize(10)
    
    // Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    @IBInspectable var titleFontName: String = defaultTitleFont.fontName {
        didSet {
            let font = UIFont(name: titleFontName, size: titleFontSize)
            titleFont = font!
        }
    }
    
    // Workaround IBInspectable does not support UIFont ( http://nsfail.net/post/125252321995/ibinspectable-should-support-nsfontuifont )
    @IBInspectable var titleFontSize: CGFloat = defaultTitleFont.pointSize {
        didSet {
            let font = titleFont.fontWithSize(titleFontSize)
            titleFont = font
        }
    }
    
    @IBInspectable public var titleFontColor: UIColor = UIColor.blackColor() {
        didSet {
            for titleLabel in countdownTitleLabels {
                titleLabel.textColor = titleFontColor
            }
            
            layoutIfNeeded()
        }
    }
    
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
    
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CountdownView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        for view in contentView.subviews {
            view.prepareForInterfaceBuilder()
        }
    }
}
