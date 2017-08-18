# SwiftHandlerKit
Super lightweight library (83 lines) to assign closure-based actions to UIControls and the like.

[![CI Status](http://img.shields.io/travis/daaavid/SwiftHandlerKit.svg?style=flat)](https://travis-ci.org/daaavid/SwiftHandlerKit)
[![Version](https://img.shields.io/cocoapods/v/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)
[![License](https://img.shields.io/cocoapods/l/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)
[![Platform](https://img.shields.io/cocoapods/p/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)

##Usage

Just use the fuction `.on`, followed by the event on any UIControl to assign an action for that event.

```
textField.on(.editingChanged) { [unowned self] textField in
  // no need to cast as UITextField
  print("editingChanged", textField.text!)
}
```

```
button.on(.touchUpInside, .touchUpOutside) { [unowned self] button in
  //multiple events
  UIView.animate(withDuration: 0.15) {
    button.transform = .identity
  }
}
```

There's also some support for UIBarButtonItems.
```
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back") { [unowned self] barButtonItem in
      print("leftBarButtonItemWasPressed")
    }
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftHandlerKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftHandlerKit'
```

If you get some sort of spec error, try `pod repo update` or:

```ruby
pod 'SwiftHandlerKit', :git => 'https://github.com/daaavid/SwiftHandlerKit.git', :branch => 'master'
```

## Author

daaavid, david.j.c.johnson@gmail.com

## License

SwiftHandlerKit is available under the MIT license. See the LICENSE file for more info.
