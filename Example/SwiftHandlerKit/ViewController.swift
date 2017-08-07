//
//  ViewController.swift
//  SwiftHandlerKit
//
//  Created by daaavid on 08/07/2017.
//  Copyright (c) 2017 daaavid. All rights reserved.
//

import UIKit
import SwiftHandlerKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add) { [unowned self] barButtonItem in
      self.presentAlert(withTitle: "rightBarButtonItemWasPressed")
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back") { [unowned self] barButtonItem in
      self.presentAlert(withTitle: "leftBarButtonItemWasPressed")
    }
    
    let textField = UITextField()
    view.addSubview(textField)
    
    textField.borderStyle = .roundedRect
    textField.frame.size = CGSize(width: 200, height: 40)
    textField.center = view.center.offsetBy(y: -textField.frame.size.height)
    
    textField.on(.editingDidBegin) { textField in
      //no need to cast as UITextField
      print("textFieldEditingDidBegin")
    }
    
    textField.on(.editingChanged) { textField in
      print("textFieldEditingChanged", textField.text!)
    }

    let button = UIButton()
    view.addSubview(button)
    
    button.setTitle("Button", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.frame.size = textField.frame.size
    button.center = view.center
    
    button.on(.touchDown) { button in
      button.setTitle("touchDown", for: .normal)
      button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
    button.on(.touchUpInside, .touchUpOutside) { button in
      //multiple events
      button.setTitle("touchUp", for: .normal)
      UIView.animate(withDuration: 0.15) {
        button.transform = .identity
      }
    }
  }
  
  func presentAlert(withTitle title: String) {
    let style: UIAlertControllerStyle = (UIDevice.current.userInterfaceIdiom == .pad) ? .alert : .actionSheet
    let alert = UIAlertController(title: title, message: nil, preferredStyle: style)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension CGPoint {
  func offsetBy(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: self.x + x, y: self.y + y)
  }
}

