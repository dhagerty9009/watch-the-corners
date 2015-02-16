//
//  InterfaceController.swift
//  Watch The Corners WatchKit Extension
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var label: WKInterfaceLabel!
  
  @IBOutlet weak var coundownTimer: WKInterfaceTimer!
  
  @IBAction func TapOne() {
    label.setText("One was tapped.")
  }
  @IBAction func TapTwo() {
    label.setText("Two was tapped.")
  }
  @IBAction func TapThree() {
    label.setText("Three was tapped.")
  }
  @IBAction func TapFour() {
    label.setText("Four was tapped.")
  }
  func update() {
    // This will be the timer loop.
  }
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    // Configure interface objects here.
  }
}
