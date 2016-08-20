//
//  AppDelegate.swift
//  PinchableLabel
//
//  Created by Koji Murata on 02/09/2016.
//  Copyright (c) 2016 Koji Murata. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func applicationDidFinishLaunching(_ application: UIApplication) {
    KTouchPointerWindowInstall()
  }
}

