//
//  ViewController.swift
//  PinchableLabel
//
//  Created by Koji Murata on 02/09/2016.
//  Copyright (c) 2016 Koji Murata. All rights reserved.
//

import UIKit
import PinchableLabel

class ViewController: UIViewController, PinchableLabelDelegate {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let label = PinchableLabel()
    label.text = "Label"
    label.sizeToFit()
    label.center = view.center
    view.addSubview(label)

    label.delegate = self
    label.handler = { (label) in
      switch label.state {
      case .Began: print("began handler")
      case .Moved: print("moved handler")
      case .Ended: print("ended handler")
      }
    }
  }
  
  func pinchableLabelTouchesBegan(pinchableLabel: PinchableLabel) {
    print("began delegate")
  }
  
  func pinchableLabelTouchesMoved(pinchableLabel: PinchableLabel) {
    print("moved delegate")
  }
  
  func pinchableLabelTouchesEnded(pinchableLabel: PinchableLabel) {
    print("ended delegate")
  }
}