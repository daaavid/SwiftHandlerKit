//
//  SwiftHandlerKit.swift
//  SwiftHandlerKit
//
//  Created by David Johnson on 7/17/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//
import UIKit
private typealias Closure = () -> Void
private class Handler: NSObject {
  var closure: Closure!
  
  init(_ closure: Closure! = nil) {
    self.closure = closure
  }
  
  func handle() { 
    closure() 
  }
}
public protocol SwiftHandlerKitProtocol: class {}
private var kHandlers: UInt8 = 0
extension SwiftHandlerKitProtocol {
  fileprivate var handlers: Set<Handler> {
    get { return getHandlers() }
    set { setHandlers(newValue) }
  }
  
  private func getHandlers() -> Set<Handler> {
    guard let handlers = objc_getAssociatedObject(self, &kHandlers) as? Set<Handler> else {
      setHandlers(Set<Handler>())
      return getHandlers()
    }
    
    return handlers
  }
  
  private func setHandlers(_ handlers: Set<Handler>) {
    objc_setAssociatedObject(self, &kHandlers, handlers, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  public func removeAllEventHandlers() {
    handlers.removeAll()
  }
}
extension UIControl: SwiftHandlerKitProtocol {}
extension SwiftHandlerKitProtocol where Self: UIControl {
  public func on(_ event: UIControlEvents, do handler: @escaping (Self) -> Void) {
    let handler = Handler { [unowned self] in handler(self) }
    addTarget(handler, action: #selector(handler.handle), for: event)
    handlers.insert(handler)
  }
}
extension UIBarButtonItem: SwiftHandlerKitProtocol {
  public convenience init(title: String?, style: UIBarButtonItemStyle = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = Handler()
    self.init(title: title, style: style, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    handlers.insert(handler)
  }
  
  public convenience init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = Handler()
    self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    handlers.insert(handler)
  }
  
  public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = Handler()
    self.init(barButtonSystemItem: systemItem, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    handlers.insert(handler)
  }
}
extension UIGestureRecognizer: SwiftHandlerKitProtocol {
  public convenience init(closure: @escaping (UIGestureRecognizer) -> Void) {
    let handler = Handler()
    self.init(target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    handlers.insert(handler)
  }
}
