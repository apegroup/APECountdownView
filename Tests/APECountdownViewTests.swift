// APECountdownViewTests.swift
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

import XCTest
@testable import APECountdownView

class APECountdownViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompleteClosure() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        let countdownView = CountdownView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
        view.addSubview(countdownView)
        
        let asyncExpectation = expectationWithDescription("Complete closure expectation")
        
        let countdownTime = 3.0 // 3 sec
        let endDate = NSDate(timeIntervalSinceNow: countdownTime)
        countdownView.startCountdown(endDate, onCompleted: { _ in
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(countdownTime + 1, handler: { error in
            XCTAssertNil(error, "Complete closure not called.")
        })
    }
    
    func testAppearance() {
        let countdownView = CountdownView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
        countdownView.size = CGSize(width: 40, height: 30)
        countdownView.groupSpace = 3
        countdownView.sectionSpace = 3
        countdownView.gradientColor1 = UIColor.blackColor()
        countdownView.gradientColor2 = UIColor.redColor()
        countdownView.gradientColor3 = UIColor.greenColor()
        countdownView.gradientColor4 = UIColor.blueColor()
        countdownView.blockFontName = UIFont.familyNames().first!
        countdownView.blockFontSize = 12
        countdownView.blockFont = UIFont.systemFontOfSize(20)
        countdownView.blockFontColor = UIColor.brownColor()
        countdownView.titleFontName = UIFont.familyNames().last!
        countdownView.titleFontSize = 8
        countdownView.titleFontColor = UIColor.yellowColor()
        countdownView.titleFont = UIFont.systemFontOfSize(20)
    }
    
    func testStringExtensions() {
        let testString1 = ""
        XCTAssertEqual(testString1, testString1.getFirstChar())
        XCTAssertEqual(testString1, testString1.getLastChar())
        
        let testString2 = String()
        XCTAssertEqual(testString2, testString2.getFirstChar())
        XCTAssertEqual(testString2, testString2.getLastChar())
        
        let testString3 = "asdf"
        XCTAssertEqual("a", testString3.getFirstChar())
        XCTAssertEqual("f", testString3.getLastChar())
    }
    
    func testNumberView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let countdownNumberView = CountdownNumberView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        countdownNumberView.drawRect(countdownNumberView.frame)
        view.addSubview(countdownNumberView)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
