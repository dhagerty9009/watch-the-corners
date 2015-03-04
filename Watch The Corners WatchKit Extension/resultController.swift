//
//  resultController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/4/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import WatchKit
import Foundation

class resultController: WKInterfaceController {
  
  // The final score from the game.
  @IBOutlet weak var finalScore: WKInterfaceLabel!
  
  @IBAction func newGame() {
    pushControllerWithName("gameController", context: nil)
  }
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    var score = context as Int?
    finalScore.setText("Final Score: \(score)")
  }
}