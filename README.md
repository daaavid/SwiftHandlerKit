# SwiftHandlerKit
Super lightweight library to assign taggable, closure-based actions to UIControls.

[![CI Status](http://img.shields.io/travis/daaavid/SwiftHandlerKit.svg?style=flat)](https://travis-ci.org/daaavid/SwiftHandlerKit)
[![Version](https://img.shields.io/cocoapods/v/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)
[![License](https://img.shields.io/cocoapods/l/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)
[![Platform](https://img.shields.io/cocoapods/p/SwiftHandlerKit.svg?style=flat)](http://cocoapods.org/pods/SwiftHandlerKit)

## Usage

Just use the fuction `.on`, followed by the event on any UIControl to assign an action for that event.

```swift
textField.on(.editingChanged) { textField in
  // no need to cast as UITextField
  print("editingChanged", textField.text!)
}
```

```swift
button.on(.touchUpInside, .touchUpOutside) { button in
  //multiple events
  UIView.animate(withDuration: 0.15) {
    button.transform = .identity
  }
}
```

The `.on` function returns an `EventHandler` object that contains your action. You can add a `tag` to this EventHandler to identify it.

```swift
let touchUpEventHandler = button.on(.touchUpInside, .touchUpOutside) { button in
  print(button)
}

touchUpEventHandler.tag = "buttonTouchUp"

// if you want, you could also do something like this

button.on(.touchDown) { button in
  print(button)
}.tag = "touchDown"

```

You can find these EventHandlers later by accessing the `eventHandlers` property (it's a Set) on the ui element you assigned the EventHandler to. You can `subcript` this set with a `tag` to find specific event handlers.

```swift
if let touchUpEventHandler = button.eventHandlers["buttonTouchUp"] {
  button.eventHandlers.remove(touchUpEventHandler)
}
```

There's also some support thrown in for UIBarButtonItems. All of the stock UIBarButtonItem inits are now available as closure-based inits.

```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back") { barButtonItem in
  print("leftBarButtonItemWasPressed")
}
```

You can create UIGestureRecognizers like this as well!

```swift
UITapGestureRecognizer { tap in
  print(tap)
}.add(to: view)
```

Take a peek into `SwiftHandlerKit.swift` if you want to know more about how it works. It's very short and pretty simple! :^)

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
