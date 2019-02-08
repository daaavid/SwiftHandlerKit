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
  let label = UILabel()
  var count = 0;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(label)
    label.frame.size = CGSize(width: view.frame.width, height: 40)
    label.center = view.center.offsetBy(y: label.frame.size.height * -2)
    label.textAlignment = .center

    
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add) { [unowned self] barButtonItem in
      print("rightBarButtonItemWasPressed")
      self.presentAlert(withTitle: "rightBarButtonItemWasPressed")
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back") { [unowned self] barButtonItem in
      print("leftBarButtonItemWasPressed")
      self.presentAlert(withTitle: "leftBarButtonItemWasPressed")
    }
    
    
    
    let textField = UITextField()
    view.addSubview(textField)
    
    textField.borderStyle = .roundedRect
    textField.frame.size = CGSize(width: 200, height: 40)
    textField.center = view.center.offsetBy(y: -textField.frame.size.height)
    
    textField.on(.editingDidBegin) { [unowned self] textField in
      //no need to cast as UITextField
      print("editingDidBegin")
      self.label.text = "editingDidBegin" 
    }
    
    textField.on(.editingChanged) { [unowned self] textField in
      print("editingChanged", textField.text!)
      self.label.text = "editingChanged " + textField.text! 
    }
    
    

    let button = UIButton()
    view.addSubview(button)
    
    button.setTitle("Button", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.frame.size = textField.frame.size
    button.center = view.center
    
    
    
    button.on(.touchUpInside, .touchDown) { [unowned self] button in
      //multiple events
      self.count += 1
      self.label.text = "touch: \(self.count)"
    }
  }
  
  func presentAlert(withTitle title: String) {
    let style: UIAlertController.Style = (UIDevice.current.userInterfaceIdiom == .pad) ? .alert : .actionSheet
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

