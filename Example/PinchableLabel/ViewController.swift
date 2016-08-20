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
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let label = PinchableLabel()
    label.numberOfLines = 0
    let text = NSMutableAttributedString(string: "hoge\n", attributes: [
      NSFontAttributeName: UIFont.systemFont(ofSize: 20),
      NSForegroundColorAttributeName: UIColor.blue,
    ])
    text.append(NSAttributedString(string: "piyopiyo", attributes: [
      NSFontAttributeName: UIFont.systemFont(ofSize: 10),
      NSForegroundColorAttributeName: UIColor.red,
    ]))
    label.attributedText = text
    label.sizeToFit()
    label.center = view.center
    view.addSubview(label)

    label.delegate = self
  }
  
  func pinchableLabelTouchesBegan(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("began delegate")
  }
  
  func pinchableLabelTouchesMoved(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("moved delegate")
  }
  
  func pinchableLabelTouchesEnded(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("ended delegate")
  }
}
