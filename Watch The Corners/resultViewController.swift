//
//  resultViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import iAd
import Social

class resultViewController: UIViewController {

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

  let FACEBOOK_TEXT = "I scored big in Watch the Corners! Try and beat me!"
  let TWITTER_TEXT  = "I scored big in @WatchCornerGame! Try and beat me!"

  let APP_URL: NSURL = NSURL(string: "https://itunes.apple.com/us/app/watch-the-corners/id978732428?ls=1&mt=8")!

  var scoresAsText = ""
  var numberOfScores = 0

  var highScore: Int!

  var newScoreText: UILabel = UILabel()
  var highScoresLabel: UILabel = UILabel()
  var highScoreText: UILabel = UILabel()
  var scoreLabel: UILabel = UILabel()

  var gameScoreTextFrame: CGRect!
  var highScoreFrame: CGRect!
  var highScoreTextFrame: CGRect!
  var gameScoreFrame: CGRect!
  var buttonFrame: CGRect!
  var logoFrame: CGRect!
  var twitterFrame: CGRect!
  var facebookFrame: CGRect!

  var button: UIButton        = UIButton.buttonWithType(UIButtonType.System) as! UIButton
  var facebookShare: UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
  var twitterShare: UIButton  = UIButton.buttonWithType(UIButtonType.System) as! UIButton

  func backToGame() {
    storage.synchronize()
    showViewController(gameViewController(), sender: self)
  }

  func makeFrames() {
    logoFrame          = CGRectMake(10, 30, WIDTH, WIDTH/4)
    gameScoreTextFrame = CGRectMake(0, WIDTH/4 + 30, WIDTH, 60)
    gameScoreFrame     = CGRectMake(0, WIDTH/2, WIDTH, 160)
    highScoreFrame     = CGRectMake(0, HEIGHT/2 + 30, WIDTH, 50)
    highScoreTextFrame = CGRectMake(0, HEIGHT/2 + 90, WIDTH, 30)
    buttonFrame        = CGRectMake(75, HEIGHT*2/3 + 65, WIDTH - 80, 70)
    twitterFrame       = CGRectMake(5, HEIGHT*2/3 + 65, 70, 70)
    facebookFrame      = CGRectMake(WIDTH - 75, HEIGHT*2/3 + 65, 70, 70)
  }

  func displayScores() {
    gameScoreLabel()
    gameScoreText()
    highScoreLabels()
    playAgainButton()
    scoreLogicHandler()
    showLogo()
  }

  func showLogo() {
    let imageView = UIImageView()
    imageView.frame = logoFrame
    imageView.image = UIImage(named: "text-logo")
    self.view.addSubview(imageView)
  }

  func scoreLogicHandler() {

    highScore = score.highScores[0]

    var topTenPercent = Int(floor(0.9 * Float(highScore)))
    var bottomTenPercent = Int(floor(0.1 * Float(highScore)))

    if score.currentScoreIsHighScore() && score.currentScore != 0 {
      newScoreText.text = "New High Score!"
      newScoreText.textColor = GREEN
      scoreLabel.textColor = GREEN
    } else if score.currentScore == 0 {
      newScoreText.text = "Better Luck Next Time!"
      newScoreText.textColor = RED
      scoreLabel.textColor = RED
    } else if (score.currentScore >= topTenPercent && highScore > score.currentScore) {
      newScoreText.text = "So Close!"
      newScoreText.textColor = DARK_GRAY
      scoreLabel.textColor = DARK_GRAY
    } else if (bottomTenPercent >= score.currentScore && score.currentScore > 0) {
      newScoreText.text = "Almost, But Not Quite..."
      newScoreText.textColor = DARK_GRAY
      scoreLabel.textColor = DARK_GRAY
    } else {
      newScoreText.text = "Good Job!"
      newScoreText.textColor = LIGHT_GRAY
      scoreLabel.textColor = LIGHT_GRAY
    }
  }

  func gameScoreText() {
    newScoreText.frame = gameScoreTextFrame
    newScoreText.textAlignment = NSTextAlignment.Center
    newScoreText.font = labelFont
    newScoreText.adjustsFontSizeToFitWidth = true
    self.view.addSubview(newScoreText)
  }

  func highScoreLabels() {
    // high score labels
    highScoresLabel.frame = highScoreFrame
    highScoresLabel.text = scoresAsText + "|"
    highScoresLabel.textAlignment = NSTextAlignment.Center
    highScoresLabel.textColor = DARK_GRAY
    highScoresLabel.font = scoreListFont
    highScoresLabel.adjustsFontSizeToFitWidth = true
    // A label to describe the high scores
    highScoreText.text = "High Scores"
    highScoreText.frame = highScoreTextFrame
    highScoreText.font = UIFont.systemFontOfSize(20)
    highScoreText.textAlignment = NSTextAlignment.Center
    highScoreText.textColor = DARK_GRAY
    self.view.addSubview(highScoresLabel)
    self.view.addSubview(highScoreText)
  }

  func gameScoreLabel() {
    // The player's score from the completed game
    scoreLabel.text = "\(score.currentScore)"
    scoreLabel.frame = gameScoreFrame
    scoreLabel.textAlignment = NSTextAlignment.Center
    scoreLabel.font = scoreFont
    self.view.addSubview(scoreLabel)
  }

  func playAgainButton() {
    // The button to allow the player to start a new game
    button.frame = buttonFrame
    button.setTitle("Play Again", forState: UIControlState.Normal)
    button.setTitleColor(DARK_GRAY, forState: UIControlState.Normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = GREEN
    button.titleLabel?.font = buttonFont
    button.titleLabel?.textAlignment = NSTextAlignment.Center
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)

    facebookShare.frame = facebookFrame
    
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

  func saveDefaults() {
    storage.setObject(score.highScores, forKey: "highScores")
  }

  func saveScreenshot(view: UIView) -> UIImage {
    var frame: CGRect = UIScreen.mainScreen().bounds
    UIGraphicsBeginImageContext(frame.size)
    let context: CGContextRef = UIGraphicsGetCurrentContext()
    view.layer.renderInContext(context)
    var screenshot: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshot
  }

  func shareOnFacebook() {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
      var composeSheet = SLComposeViewController.init(forServiceType: SLServiceTypeFacebook)
      composeSheet.addImage(saveScreenshot(view))
      composeSheet.setInitialText(FACEBOOK_TEXT)
      composeSheet.addURL(APP_URL)
    }
  }

  func shareOnTwitter() {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
      var composeSheet = SLComposeViewController.init(forServiceType: SLServiceTypeTwitter)
      composeSheet.addImage(saveScreenshot(view))
      composeSheet.setInitialText(TWITTER_TEXT)
      composeSheet.addURL(APP_URL)
    }
  }


  override func viewDidLoad() {
    super.viewDidLoad()

    loadDefaults()
    score.addScoreToHighScores(score.currentScore)
    saveDefaults()

    self.canDisplayBannerAds = true
    self.view.backgroundColor = WHITE

    makeFrames()
    formatHighScores()
    displayScores()

  }
}
