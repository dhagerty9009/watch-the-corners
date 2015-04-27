//
//  AppDelegate.swift
//  Watch The Corners
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let storage = NSUserDefaults.standardUserDefaults()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Fabric.with([Crashlytics(), Twitter()])
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func application(application: UIApplication,
    openURL url: NSURL,
    sourceApplication: String?,
    annotation: AnyObject?) -> Bool {
      return FBSDKApplicationDelegate.sharedInstance().application(
        application,
        openURL: url,
        sourceApplication: sourceApplication,
        annotation: annotation)
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
    FBSDKAppEvents.activateApp()
  }

  func applicationWillTerminate(application: UIApplication) {
    storage.synchronize()
  }


}

