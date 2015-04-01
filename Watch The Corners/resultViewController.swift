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
  let scoreListFont = UIFont.systemFontOfSize(40)

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
    var numberOfScores = 0

    for value in score.highScores {
      if value > 0 {
        numberOfScores++
        scoresAsText = scoresAsText + "| \(value) "
      }
    }

    self.canDisplayBannerAds = true

    self.view.backgroundColor = WHITE

    // The button to allow the player to start a new game
    var button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    button.frame = CGRectMake(5, HEIGHT*2/3 + 30, WIDTH-10, 60)
    button.setTitle("Play Again", forState: UIControlState.Normal)
    button.setTitleColor(GRAY, forState: UIControlState.Normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = GREEN
    button.titleLabel?.font = buttonFont
    button.titleLabel?.textAlignment = NSTextAlignment.Center
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)

    // The player's score from the completed game
    var scoreLabel: UILabel = UILabel()
    scoreLabel.text = "\(score.currentScore)"
    scoreLabel.frame = CGRectMake(0, 125, WIDTH, 160)
    scoreLabel.textAlignment = NSTextAlignment.Center
    scoreLabel.textColor = GREEN
    scoreLabel.font = scoreFont
    self.view.addSubview(scoreLabel)

    // high score labels
    var highScoresLabel: UILabel = UILabel()
    highScoresLabel.frame = CGRectMake(0, HEIGHT/2, WIDTH, 50)
    highScoresLabel.text = scoresAsText + "|"
    highScoresLabel.textAlignment = NSTextAlignment.Center
    highScoresLabel.textColor = RED
    highScoresLabel.font = scoreListFont
    var highScoreText: UILabel = UILabel()
    highScoreText.text = "High Scores"
    highScoreText.frame = CGRectMake(0, HEIGHT/2 + 50, WIDTH, 30)
    highScoreText.font = UIFont.systemFontOfSize(20)
    highScoreText.textAlignment = NSTextAlignment.Center
    highScoreText.textColor = RED
    if numberOfScores > 1 {
      self.view.addSubview(highScoresLabel)
      self.view.addSubview(highScoreText)
    }

    // Text displayed changes based on the score.
    var newScoreText: UILabel = UILabel()
    if score.currentScoreIsHighScore() && score.currentScore != 0 {
      newScoreText.text = "New High Score!"
    } else if score.currentScore == 0 {
      newScoreText.text = "Better Luck Next Time!"
    } else {
      newScoreText.text = "Good Job!"
    }
    newScoreText.textColor = GREEN
    newScoreText.frame = CGRectMake(0, 50, WIDTH, 60)
    newScoreText.textAlignment = NSTextAlignment.Center
    newScoreText.font = labelFont
    self.view.addSubview(newScoreText)
  }
}
