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

  let storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()

  let score = Score.sharedInstance

  // The final score from the game.
  @IBOutlet weak var finalScore: WKInterfaceLabel!

  @IBOutlet weak var thirdScore: WKInterfaceLabel!
  @IBOutlet weak var secondScore: WKInterfaceLabel!
  @IBOutlet weak var highestScore: WKInterfaceLabel!

  @IBAction func startNewGame() {
    pushControllerWithName("gameController", context: nil)
  }

  func loadDefaults() {
    storage.synchronize()
    if storage.arrayForKey("watchHighScores") != nil {
      score.highScores = storage.arrayForKey("watchHighScores") as [Int]
    }
  }

  func saveDefaults() {
    storage.setObject(score.highScores, forKey: "watchHighScores")
  }

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    loadDefaults()
    score.addScoreToHighScores(score.currentScore)
    saveDefaults()

    finalScore.setText("\(score.currentScore)")
    highestScore.setText("\(score.highScores[0])")
    secondScore.setText("\(score.highScores[1])")
    thirdScore.setText("\(score.highScores[2])")
  }
}
