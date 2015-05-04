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
import Fabric
import TwitterKit

class resultViewController: UIViewController {

  let storage = NSUserDefaults.standardUserDefaults()
  let score   = Score.sharedInstance

  let WHITE: UIColor        = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor        = UIColor.blackColor()
  let GREEN: UIColor        = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let DARK_GRAY: UIColor    = UIColor.init(red: 0.18, green: 0.19, blue: 0.2, alpha: 1)
  let LIGHT_GRAY: UIColor   = UIColor.lightGrayColor()
  let RED : UIColor         = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  let WIDTH  = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height

  let labelFont     = UIFont.boldSystemFontOfSize(30)
  let buttonFont    = UIFont.systemFontOfSize(30)
  let scoreFont     = UIFont.boldSystemFontOfSize(150)
  let scoreListFont = UIFont.systemFontOfSize(40)

  let FACEBOOK_TEXT = "I scored big in Watch the Corners! Try and beat me!"
  let TWITTER_TEXT  = "I scored big in #watchthecorners! Try and beat me!"

  let APP_URL: NSURL = NSURL(string: "https://fb.me/447414902098603")!

  var scoresAsText   = ""
  var numberOfScores = 0

  var highScore: Int!

  var newScoreText: UILabel    = UILabel()
  var highScoresLabel: UILabel = UILabel()
  var highScoreText: UILabel   = UILabel()
  var scoreLabel: UILabel      = UILabel()

  var gameScoreTextFrame: CGRect!
  var highScoreFrame:     CGRect!
  var highScoreTextFrame: CGRect!
  var gameScoreFrame:     CGRect!
  var buttonFrame:        CGRect!
  var logoFrame:          CGRect!
  var twitterFrame:       CGRect!
  var facebookFrame:      CGRect!



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
    buttonFrame        = CGRectMake(80, HEIGHT*2/3 + 65, WIDTH - 160, 70)
    twitterFrame       = CGRectMake(WIDTH - 65, HEIGHT*2/3 + 75, 50, 50)
    facebookFrame      = CGRectMake(15, HEIGHT*2/3 + 75, 50, 50)
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

    var topTenPercent    = Int(floor(0.9 * Float(highScore)))
    var bottomTenPercent = Int(floor(0.1 * Float(highScore)))

    if !score.duplicateScore {
      if score.currentScoreIsHighScore() && score.currentScore != 0 {
        newScoreText.text      = "New High Score!"
        newScoreText.textColor = GREEN
        scoreLabel.textColor   = GREEN
      } else if score.currentScore == 0 {
        newScoreText.text      = "Better Luck Next Time!"
        newScoreText.textColor = RED
        scoreLabel.textColor   = RED
      } else if (score.currentScore >= topTenPercent && highScore > score.currentScore) {
        newScoreText.text      = "So Close!"
        newScoreText.textColor = DARK_GRAY
        scoreLabel.textColor   = DARK_GRAY
      } else if (bottomTenPercent >= score.currentScore && score.currentScore > 0) {
        newScoreText.text      = "Almost, But Not Quite..."
        newScoreText.textColor = DARK_GRAY
        scoreLabel.textColor   = DARK_GRAY
      } else {
        newScoreText.text      = "Good Job!"
        newScoreText.textColor = LIGHT_GRAY
        scoreLabel.textColor   = LIGHT_GRAY
      }
    } else if score.duplicateScore {
      newScoreText.text      = "Better Luck Next Time!"
      newScoreText.textColor = DARK_GRAY
      scoreLabel.textColor   = DARK_GRAY
    }
  }

  func gameScoreText() {
    newScoreText.frame                     = gameScoreTextFrame
    newScoreText.textAlignment             = NSTextAlignment.Center
    newScoreText.font                      = labelFont
    newScoreText.adjustsFontSizeToFitWidth = true
    self.view.addSubview(newScoreText)
  }

  func highScoreLabels() {
    // high score labels
    highScoresLabel.frame                     = highScoreFrame
    highScoresLabel.text                      = scoresAsText + "|"
    highScoresLabel.textAlignment             = NSTextAlignment.Center
    highScoresLabel.textColor                 = DARK_GRAY
    highScoresLabel.font                      = scoreListFont
    highScoresLabel.adjustsFontSizeToFitWidth = true
    // A label to describe the high scores
    highScoreText.text                        = "High Scores"
    highScoreText.frame                       = highScoreTextFrame
    highScoreText.font                        = UIFont.systemFontOfSize(20)
    highScoreText.textAlignment               = NSTextAlignment.Center
    highScoreText.textColor                   = DARK_GRAY
    self.view.addSubview(highScoresLabel)
    self.view.addSubview(highScoreText)
  }

  func gameScoreLabel() {
    // The player's score from the completed game
    scoreLabel.text          = "\(score.currentScore)"
    scoreLabel.frame         = gameScoreFrame
    scoreLabel.textAlignment = NSTextAlignment.Center
    scoreLabel.font          = scoreFont
    self.view.addSubview(scoreLabel)
  }

  func playAgainButton() {
    // The button to allow the player to start a new game
    let button                       = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    button.frame                     = buttonFrame
    button.layer.cornerRadius        = 10
    button.backgroundColor           = GREEN
    button.titleLabel?.font          = buttonFont
    button.titleLabel?.textAlignment = NSTextAlignment.Center

    button.setTitle("Play Again", forState: UIControlState.Normal)
    button.setTitleColor(DARK_GRAY, forState: UIControlState.Normal)
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)

    self.view.addSubview(button)

    // The button that shares to Facebook
    let facebookShare            = UIButton.buttonWithType(.Custom) as! UIButton
    facebookShare.frame          = facebookFrame

    facebookShare.setImage(UIImage(named: "facebook-logo"), forState: UIControlState.Normal)
    facebookShare.addTarget(self, action: Selector("shareToFacebook"), forControlEvents: .TouchUpInside)
    self.view.addSubview(facebookShare)

    // The button that shares to Twitter
    let twitterShare             = UIButton.buttonWithType(.Custom) as! UIButton
    twitterShare.frame           = twitterFrame

    twitterShare.setImage(UIImage(named: "twitter-logo-white"), forState: UIControlState.Normal)

    twitterShare.layer.cornerRadius = 5
    twitterShare.addTarget(self, action: Selector("shareToTwitter"), forControlEvents: .TouchUpInside)
    self.view.addSubview(twitterShare)
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
    var frame: CGRect         = CGRectMake(0, 0, WIDTH, (WIDTH/2) + 162)
    UIGraphicsBeginImageContext(frame.size)
    let context: CGContextRef = UIGraphicsGetCurrentContext()
    view.layer.renderInContext(context)
    var screenshot: UIImage   = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshot
  }

  func shareToFacebook() {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
      var sharesheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
      sharesheet.setInitialText(FACEBOOK_TEXT)
      sharesheet.addImage(saveScreenshot(view))
      sharesheet.addURL(APP_URL)
      self.presentViewController(sharesheet, animated: true, completion: nil)
    }
  }

  func shareToTwitter() {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
      var sharesheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      sharesheet.setInitialText(TWITTER_TEXT)
      sharesheet.addImage(saveScreenshot(view))
      sharesheet.addURL(APP_URL)
      self.presentViewController(sharesheet, animated: true, completion: nil)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadDefaults()
    score.reportToGameCenter()
    score.addScoreToHighScores(score.currentScore)
    saveDefaults()

    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
    self.canDisplayBannerAds            = true
    self.view.backgroundColor           = WHITE

    makeFrames()
    formatHighScores()
    displayScores()

  }
}
