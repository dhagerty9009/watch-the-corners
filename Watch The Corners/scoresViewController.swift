//
//  scoresViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 4/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import iAd

class scoresViewController: UIViewController {

  let storage = NSUserDefaults.standardUserDefaults()
  let score   = Score.sharedInstance

  let WHITE: UIColor      = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor      = UIColor.blackColor()
  let GREEN: UIColor      = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let DARK_GRAY: UIColor  = UIColor.init(red: 0.18, green: 0.19, blue: 0.2, alpha: 1)
  let LIGHT_GRAY: UIColor = UIColor.lightGrayColor()
  let RED : UIColor       = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  let WIDTH  = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height

  let labelFont     = UIFont.boldSystemFontOfSize(30)
  let buttonFont    = UIFont.systemFontOfSize(50)
  let scoreFont     = UIFont.boldSystemFontOfSize(150)
  let scoreListFont = UIFont.systemFontOfSize(40)

  var scoresAsText   = ""
  var numberOfScores = 0

  var highScore: Int!

  var newScoreText: UILabel    = UILabel()
  var highScoresLabel: UILabel = UILabel()
  var scoreLabel: UILabel      = UILabel()
  var highScoreText: UIButton  = UIButton.buttonWithType(.System) as! UIButton
  var button: UIButton         = UIButton.buttonWithType(UIButtonType.System) as! UIButton

  func backToGame() {
    storage.synchronize()
    showViewController(gameViewController(), sender: self)
  }

  func goToGameCenter() {
    GCHelper.showGameCenter(self, viewState: .Leaderboards)
  }


  func displayScores() {
    showLogo()
    highScoreLabels()
    playAgainButton()
  }

  func showLogo() {
    let imageView = UIImageView()
    imageView.frame = CGRectMake(WIDTH/8, 30, WIDTH*3/4, WIDTH*3/4)
    imageView.image = UIImage(named: "logo")
    self.view.addSubview(imageView)
  }

  func highScoreLabels() {
    // high score labels
    highScoresLabel.frame                     = CGRectMake(0, HEIGHT/2 + 20, WIDTH, 50)
    highScoresLabel.text                      = scoresAsText + "|"
    highScoresLabel.textAlignment             = NSTextAlignment.Center
    highScoresLabel.textColor                 = DARK_GRAY
    highScoresLabel.font                      = scoreListFont
    highScoresLabel.adjustsFontSizeToFitWidth = true
    // A label to describe the high scores
    highScoreText.frame                     = CGRectMake(0, HEIGHT/2 + 70, WIDTH, 30)
    highScoreText.titleLabel?.font          = UIFont.systemFontOfSize(20)
    highScoreText.titleLabel?.textAlignment = NSTextAlignment.Center

    highScoreText.setTitle("High Scores", forState: .Normal)
    highScoreText.setTitleColor(DARK_GRAY, forState: .Normal)
    highScoreText.addTarget(self, action: Selector("goToGameCenter"), forControlEvents: .TouchUpInside)

    self.view.addSubview(highScoresLabel)
    self.view.addSubview(highScoreText)
  }

  func playAgainButton() {
    // The button to allow the player to start a new game
    button.frame                     = CGRectMake(5, HEIGHT*2/3 + 30, WIDTH-10, 60)
    button.layer.cornerRadius        = 10
    button.backgroundColor           = GREEN
    button.titleLabel?.font          = buttonFont
    button.titleLabel?.textAlignment = NSTextAlignment.Center

    button.setTitle("Play Game", forState: UIControlState.Normal)
    button.setTitleColor(DARK_GRAY, forState: UIControlState.Normal)
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)

    self.view.addSubview(button)
  }

  func formatHighScores() {
    for value in score.highScores {
      if value > 0 {
        scoresAsText = scoresAsText + "| \(value) "
      } else if value == 0 {
        scoresAsText = scoresAsText + "| 0 "
      }
    }
  }


  func loadDefaults() {
    storage.synchronize()
    if storage.arrayForKey("highScores") != nil {
      score.highScores = storage.arrayForKey("highScores") as! [Int]
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadDefaults()

    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
    self.canDisplayBannerAds = true
    self.view.backgroundColor = WHITE

    formatHighScores()
    displayScores()

  }

}
