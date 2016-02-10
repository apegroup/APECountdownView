//
//  CountdownView.swift
//  APECountdownView
//
//  Created by Daniel Nilsson on 09/02/16.
//  Copyright © 2016 Apegroup. All rights reserved.
//

import UIKit
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
    
    @IBInspectable public var blockFont: UIFont = UIFont.boldSystemFontOfSize(16) {
        didSet {
            countdownNumberViewDay1.label.font = blockFont
            countdownNumberViewDay2.label.font = blockFont
            countdownNumberViewHour1.label.font = blockFont
            countdownNumberViewHour2.label.font = blockFont
            countdownNumberViewMin1.label.font = blockFont
            countdownNumberViewMin2.label.font = blockFont
            countdownNumberViewSec1.label.font = blockFont
            countdownNumberViewSec2.label.font = blockFont
            
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var titleFont: UIFont = UIFont.systemFontOfSize(10) {
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
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
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
