# PinchableLabel

[![Platform](https://img.shields.io/cocoapods/p/PinchableLabel.svg?style=flat)](http://cocoapods.org/pods/PinchableLabel)
![Language](https://img.shields.io/badge/language-Swift%202.1-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/PinchableLabel.svg?style=flat)](http://cocoapods.org/pods/PinchableLabel)
![License](https://img.shields.io/github/license/malt03/PinchableLabel.svg?style=flat)

![Screen Shot](https://raw.githubusercontent.com/malt03/PinchableLabel/master/screen_shot.gif)

## Usage

### Initialize
```swift
let label = PinchableLabel()
label.text = "Label"
label.sizeToFit()
label.center = view.center
view.addSubview(label)
```

### Delegate
```swift
protocol PinchableLabelDelegate {
  optional func pinchableLabelTouchesBegan(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
  optional func pinchableLabelTouchesMoved(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
  optional func pinchableLabelTouchesEnded(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
}
```

## Installation via Carthage

PinchableLabel is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "malt03/PinchableLabel"
```

## Installation via CocoaPods

PinchableLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PinchableLabel"
```

## Author

Koji Murata, malt.koji@gmail.com

## License

PinchableLabel is available under the MIT license. See the LICENSE file for more info.
