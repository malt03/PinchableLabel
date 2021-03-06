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
    label.numberOfLines = 0
    let text = NSMutableAttributedString(string: "hoge\n", attributes: [
      NSFontAttributeName: UIFont.systemFontOfSize(20),
      NSForegroundColorAttributeName: UIColor.blueColor(),
    ])
    text.appendAttributedString(NSAttributedString(string: "piyopiyo", attributes: [
      NSFontAttributeName: UIFont.systemFontOfSize(10),
      NSForegroundColorAttributeName: UIColor.redColor(),
    ]))
    label.attributedText = text
    label.sizeToFit()
    label.center = view.center
    view.addSubview(label)

    label.delegate = self
  }
  
  func pinchableLabelTouchesBegan(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("began delegate")
  }
  
  func pinchableLabelTouchesMoved(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("moved delegate")
  }
  
  func pinchableLabelTouchesEnded(pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("ended delegate")
  }
}