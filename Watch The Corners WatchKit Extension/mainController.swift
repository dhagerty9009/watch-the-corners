//
//  mainController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/2/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import WatchKit
import Foundation

class mainController: WKInterfaceController {

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }
  
  @IBAction func startGame() {
    pushControllerWithName("gameController", context: nil)
  }
}