// ViewController.swift
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

import UIKit
import APECountdownView

class ViewController: UIViewController {

    @IBOutlet weak var countdownView: CountdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change appearance
        countdownView.size = CGSize(width: 40, height: 30)
        countdownView.groupSpace = -3
        countdownView.sectionSpace = 3
        countdownView.gradientColor1 = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000)
        countdownView.gradientColor2 = UIColor(red: 0.153, green: 0.153, blue: 0.153, alpha: 1.000)
        countdownView.gradientColor3 = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1.000)
        countdownView.gradientColor4 = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1.000)
        countdownView.blockFont = UIFont.boldSystemFontOfSize(16)
        countdownView.blockFontColor = UIColor.whiteColor()
        countdownView.titleFont = UIFont.systemFontOfSize(10)
        countdownView.titleFontColor = UIColor.blackColor()
        
        // Create a test time
        let days = 86400000.0 * 20  // 20 days
        let hours = 3600.0 * 20     // 20 hours
        let minutes = 60.0 * 20     // 20 minutes
        let seconds = 1.0 * 20      // 20 seconds
        
        let endDate = NSDate(timeIntervalSinceNow: days + hours + minutes + seconds)
        countdownView.startCountdown(endDate, onCompleted: { _ in
            print("Countdown completed!")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

