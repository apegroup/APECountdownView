#APECountdownView
A simple and easy count down view.

<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/16682908/13053024/8cc5c35e-d402-11e5-9370-94ee2e5752cc.gif" alt="Countdown">
</p>

##Requirements
- iOS 8 or later.
- Xcode 7 or later.

##Installation
####CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `APECountdownView` by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'APECountdownView', :git => 'https://github.com/apegroup/APECountdownView.git'
end
```
Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:

####Carthage
You can use [Carthage](https://github.com/Carthage/Carthage) to install `APECountdownView` by adding it to your `Cartfile`:
```
github "apegroup/APECountdownView"
```
Make sure to add APECountdownView.framework, RxSwift.framework and RxCocoa.framework to "Linked Frameworks and Libraries" and "copy-frameworks" Build Phases.

Note if you link with a .framework file you can't use IBDesignable and IBInspectable. Instead you have to manually write class: CountdownView and module: APECountdownView in your UIView within interface builder. Then change the appearance in code.
[Bug report](https://openradar.appspot.com/23114017) 

##Usage interface builder
- Drag a UIView into your storyboard (or nib file).
- Change class to CountdownView.
- You can now modify the appearance directly from Interface builder.
![screenshot](https://cloud.githubusercontent.com/assets/16682908/12980428/aa9a6f34-d0dc-11e5-967a-9ca408336529.png)

##Usage code
Don't forget to import.
```swift
import APECountdownView
```

Connect your countDownView from interface builder
```swift
@IBOutlet weak var countdownView: CountdownView!
```
####Start the countdown
```swift
let days = 86400000.0 * 20  // 20 days
let hours = 3600.0 * 20     // 20 hours
let minutes = 60.0 * 20     // 20 minutes
let seconds = 1.0 * 20      // 20 seconds

let endDate = NSDate(timeIntervalSinceNow: days + hours + minutes + seconds)
countdownView.startCountdown(endDate, onCompleted: { _ in
    print("Countdown completed!")
})
```
####Change appearance
```swift
countdownView.size = CGSize(width: 30, height: 40)
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
```

##Contributing
All people are welcome to contribute. See CONTRIBUTING for details.

##License
APECountdownView is released under the MIT license. See LICENSE for details.
