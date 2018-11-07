// CountdownViewModel.swift
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
The view model all logic for the framework.
*/
class CountdownViewModel {
    
    /**
     Observe countdown and call next when new data how mush time is left.

     - parameter endDate when counter should end.
     - returns: Observable
    */
    func observeCountdown(endDate: Date) -> Observable<CountdownTimeLeft> {
        return Observable.create { [weak self] observer in
            let queue = DispatchQueue.global(qos: .default)
            let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)

            timer.schedule(deadline: .now(), repeating: .milliseconds(100), leeway: .seconds(0))
            let cancel = Disposables.create {
                timer.cancel()
            }
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                
                if self!.isCountdownCompleted(endDate: endDate) {
                    observer.onCompleted()
                } else {
                    observer.on(.next(self!.parseCountdownTimeLeft(endDate: endDate)))
                }
            }
            
            timer.resume()
            
            return cancel
        }
    }
    
    /**
     Parse time left before the countdown ends.
     
     - parameter endDate when counter should end.
     - returns: Days, hours, minutes and seconds left before countdown ends.
    */
    private func parseCountdownTimeLeft(endDate: Date) -> CountdownTimeLeft {
        let currentDate = Date()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: endDate)
        
        var countdownTimeLeft = CountdownTimeLeft()
        
        if (components.second! < 0) {
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
            let days = String(format: "%02d", components.day!)
            countdownTimeLeft.day1 = days.getFirstChar()
            countdownTimeLeft.day2 = days.getLastChar()
            
            let hours = String(format: "%02d", components.hour!)
            countdownTimeLeft.hour1 = hours.getFirstChar()
            countdownTimeLeft.hour2 = hours.getLastChar()
            
            let minutes = String(format: "%02d", components.minute!)
            countdownTimeLeft.min1 = minutes.getFirstChar()
            countdownTimeLeft.min2 = minutes.getLastChar()
            
            let seconds = String(format: "%02d", components.second!)
            countdownTimeLeft.sec1 = seconds.getFirstChar()
            countdownTimeLeft.sec2 = seconds.getLastChar()
        }
        
        return countdownTimeLeft
    }
    
    /**
     Determine if the end date is completed.

     - returns: Completed or not
    */
    private func isCountdownCompleted(endDate: Date) -> Bool {
        let currentDate = Date()
        return currentDate.compare(endDate) == .orderedDescending
    }
}
