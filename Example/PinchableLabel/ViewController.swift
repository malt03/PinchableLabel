//
//  ViewController.swift
//  PinchableLabel
//
//  Created by Koji Murata on 02/09/2016.
//  Copyright (c) 2016 Koji Murata. All rights reserved.
//

import UIKit
import PinchableLabel

class ViewController: UIViewController {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let label = PinchableLabel()
    label.text = "Label"
    label.sizeToFit()
    label.center = view.center
    view.addSubview(label)
  }
}