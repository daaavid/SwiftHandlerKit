//
//  SwiftHandlerKit.swift
//  SwiftHandlerKit
//
//  Created by David Johnson on 7/17/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//
import UIKit

typealias Closure = () -> Void

public class EventHandler: NSObject {
  var closure: Closure!
  var tag = ""
  
  init(_ closure: Closure! = nil) {
    self.closure = closure
  }
  
  @objc func handle() { closure() }
}

extension Collection where Self.Iterator.Element: EventHandler {
  public subscript(_ tag: String) -> EventHandler? {
    return filter { $0.tag == tag }.first 
  }
}

public protocol SwiftHandlerKitProtocol: class {}

private var kHandlers: UInt8 = 0
extension SwiftHandlerKitProtocol {
  public var eventHandlers: Set<EventHandler> {
    get { return getHandlers() }
    set { setHandlers(newValue) }
  }
  
  private func getHandlers() -> Set<EventHandler> {
    guard let handlers = objc_getAssociatedObject(self, &kHandlers) as? Set<EventHandler> else {
      setHandlers(Set<EventHandler>())
      return getHandlers()
    }
    
    return handlers
  }
  
  private func setHandlers(_ handlers: Set<EventHandler>) {
    objc_setAssociatedObject(self, &kHandlers, handlers, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

extension UIControl: SwiftHandlerKitProtocol {}
extension SwiftHandlerKitProtocol where Self: UIControl {
  @discardableResult
  public func on(_ events: UIControl.Event..., do handler: @escaping (Self) -> Void) -> EventHandler {
    let handler = EventHandler { [unowned self] in handler(self) }
    eventHandlers.insert(handler)
    events.forEach { event in
      addTarget(handler, action: #selector(handler.handle), for: event)
    }
    return handler
  }
}

extension UIBarButtonItem: SwiftHandlerKitProtocol {
  @discardableResult
  public convenience init(title: String?, style: UIBarButtonItem.Style = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = EventHandler()
    self.init(title: title, style: style, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    eventHandlers.insert(handler)
  }
  
  public convenience init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = EventHandler()
    self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    eventHandlers.insert(handler)
  }
  
  public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, closure: @escaping (UIBarButtonItem) -> Void) {
    let handler = EventHandler()
    self.init(barButtonSystemItem: systemItem, target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    eventHandlers.insert(handler)
  }
}

extension UIGestureRecognizer: SwiftHandlerKitProtocol {
  public convenience init(closure: @escaping (UIGestureRecognizer) -> Void) {
    let handler = EventHandler()
    self.init(target: handler, action: #selector(handler.handle))
    handler.closure = { [unowned self] in closure(self) }
    eventHandlers.insert(handler)
  }
}
