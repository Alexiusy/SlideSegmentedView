# SlideSegmentedView

[![CI Status](https://img.shields.io/travis/Alexiusy/SlideSegmentedView.svg?style=flat)](https://travis-ci.org/Alexiusy/SlideSegmentedView)
[![Version](https://img.shields.io/cocoapods/v/SlideSegmentedView.svg?style=flat)](https://cocoapods.org/pods/SlideSegmentedView)
[![License](https://img.shields.io/cocoapods/l/SlideSegmentedView.svg?style=flat)](https://cocoapods.org/pods/SlideSegmentedView)
[![Platform](https://img.shields.io/cocoapods/p/SlideSegmentedView.svg?style=flat)](https://cocoapods.org/pods/SlideSegmentedView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Sample Code
```swift
let segmentedView = SlideSegmentedView()
segmentedView.normalColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
segmentedView.selectedColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
segmentedView.startColors = [.green, .blue]
segmentedView.endColors = [.orange, .cyan]
segmentedView.numberOfSegments = 20
segmentedView.currentIndexChanged = { index in
    print("index \(index) selected")
}
```
## Requirements

## Installation

SlideSegmentedView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SlideSegmentedView'
```

## Author

Alexiusy, andreboot42@gmail.com

## License

SlideSegmentedView is available under the MIT license. See the LICENSE file for more info.
