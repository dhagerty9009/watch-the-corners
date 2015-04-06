//
//  AppDelegate.swift
//  Watch The Corners
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let storage = NSUserDefaults.standardUserDefaults()


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    storage.synchronize()
  }

  func applicationDidEnterBackground(application: UIApplication) {
    storage.synchronize()
  }

  func applicationWillEnterForeground(application: UIApplication) {

  }

  func applicationDidBecomeActive(application: UIApplication) {

  }

  func applicationWillTerminate(application: UIApplication) {
    storage.synchronize()
  }


}

