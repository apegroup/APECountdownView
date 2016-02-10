//
//  ViewController.swift
//  APECountdownViewDemo
//
//  Created by Daniel Nilsson on 10/02/16.
//  Copyright © 2016 Apegroup. All rights reserved.
//

import UIKit
import APECountdownView

class ViewController: UIViewController {

    @IBOutlet weak var countdownView: CountdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

