//
//  resultViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import iAd

class resultViewController: UIViewController {

  let storage = NSUserDefaults.standardUserDefaults()

  let WHITE: UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor = UIColor.blackColor()
  let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor = UIColor.init(red: 0.18, green: 0.19, blue: 0.2, alpha: 1)
  let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  let WIDTH = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height

  let labelFont = UIFont.boldSystemFontOfSize(30)
  let buttonFont = UIFont.systemFontOfSize(50)
  let scoreFont = UIFont.boldSystemFontOfSize(150)

  func backToGame() {
    showViewController(gameViewController(), sender: self)
  }

  let score = Score.sharedInstance

  override func viewDidLoad() {
    super.viewDidLoad()

    storage.setObject(score.highScores, forKey: "highScores")

    score.highScores = storage.arrayForKey("highScores") as [Int]

    score.addScoreToHighScores(score.currentScore)

    NSLog("High Scores: \(score.highScores)")

    var scoresAsText = ""

    for value in score.highScores {
      if value > 0 {
        scoresAsText = scoresAsText + "\(value) | "
      }
    }

    self.canDisplayBannerAds = true

    self.view.backgroundColor = WHITE

    var button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton

    button.frame = CGRectMake(5, HEIGHT*2/3 - 10, WIDTH-10, 60)
    button.setTitle("Play Again", forState: UIControlState.Normal)
    button.setTitleColor(GRAY, forState: UIControlState.Normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = GREEN
    button.titleLabel?.font = buttonFont
    button.titleLabel?.textAlignment = NSTextAlignment.Center
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)

    var scoreLabel: UILabel = UILabel()
    scoreLabel.text = "\(score.currentScore)"
    scoreLabel.frame = CGRectMake(0, 125, WIDTH, 160)
    scoreLabel.textAlignment = NSTextAlignment.Center
    scoreLabel.textColor = GREEN
    scoreLabel.font = scoreFont
    self.view.addSubview(scoreLabel)

    var highScoreText: UILabel = UILabel()
    if score.currentScoreIsHighScore() && score.currentScore != 0 {
      highScoreText.text = "New High Score!"
    } else if score.currentScore == 0 {
      highScoreText.text = "Better Luck Next Time!"
    } else {
      highScoreText.text = "Good Job!"
    }
    highScoreText.textColor = GREEN
    highScoreText.frame = CGRectMake(0, 50, WIDTH, 60)
    highScoreText.textAlignment = NSTextAlignment.Center
    highScoreText.font = labelFont
    self.view.addSubview(highScoreText)
  }
}
