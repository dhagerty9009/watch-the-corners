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
  
  @IBOutlet weak var scoreLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    var highScore = context as Int?
    if highScore > 0 {
      scoreLabel.setText("High Score: \(highScore)")
    } else {
      scoreLabel.setText("No High Score")
    }
  }
  
  @IBAction func startGame() {
    pushControllerWithName("gameController", context: nil)
  }
}