//
//  CountdownViewModel.swift
//  Countdown
//
//  Created by Daniel Nilsson on 02/11/15.
//  Copyright © 2015 Daniel Nilsson. All rights reserved.
//

import RxSwift

class CountdownViewModel {
    
    /**
     Observe countdown and call next when new data how mush time is left.

     - parameter endDate when counter should end.
     - returns: Observable
    */
    func observeCountdown(endDate: NSDate) -> Observable<CountdownTimeLeft> {
        return Observable.create { [weak self] observer in
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
            
            dispatch_source_set_timer(timer, 0, UInt64(0.1 * Double(NSEC_PER_SEC)), 0)
            let cancel = AnonymousDisposable {
                dispatch_source_cancel(timer)
            }
            dispatch_source_set_event_handler(timer, {
                if cancel.disposed {
                    return
                }
                
                if self!.isCountdownCompleted(endDate) {
                    observer.onCompleted()
                } else {
                    observer.on(.Next(self!.parseCountdownTimeLeft(endDate)))
                }
            })
            
            dispatch_resume(timer)
            
            return cancel
        }
    }
    
    /**
     Parse time left before the countdown ends.
     
     - parameter endDate when counter should end.
     - returns: Days, hours, minutes and seconds left before countdown ends.
    */
    private func parseCountdownTimeLeft(endDate: NSDate) -> CountdownTimeLeft {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: currentDate, toDate: endDate, options: [])
        
        var countdownTimeLeft = CountdownTimeLeft()
        
        if (components.second < 0) {
            countdownTimeLeft.day1 = "0"
            countdownTimeLeft.day2 = "0"
            
            countdownTimeLeft.hour1 = "0"
            countdownTimeLeft.hour2 = "0"
            
            countdownTimeLeft.min1 = "0"
            countdownTimeLeft.min2 = "0"
            
            countdownTimeLeft.sec1 = "0"
            countdownTimeLeft.sec2 = "0"
        }
        else {
            let days = String(format: "%02d", components.day)
            countdownTimeLeft.day1 = days.getFirstChar()
            countdownTimeLeft.day2 = days.getLastChar()
            
            let hours = String(format: "%02d", components.hour)
            countdownTimeLeft.hour1 = hours.getFirstChar()
            countdownTimeLeft.hour2 = hours.getLastChar()
            
            let minutes = String(format: "%02d", components.minute)
            countdownTimeLeft.min1 = minutes.getFirstChar()
            countdownTimeLeft.min2 = minutes.getLastChar()
            
            let seconds = String(format: "%02d", components.second)
            countdownTimeLeft.sec1 = seconds.getFirstChar()
            countdownTimeLeft.sec2 = seconds.getLastChar()
        }
        
        return countdownTimeLeft
    }
    
    private func isCountdownCompleted(endDate: NSDate) -> Bool {
        let currentDate = NSDate()
        return currentDate.compare(endDate) == .OrderedDescending
    }
}
