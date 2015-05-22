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

  let WHITE: UIColor        = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor        = UIColor.blackColor()
  let GREEN: UIColor        = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let DARK_GRAY: UIColor    = UIColor.init(red: 0.18, green: 0.19, blue: 0.2, alpha: 1)
  let LIGHT_GRAY: UIColor   = UIColor.lightGrayColor()
  let RED : UIColor         = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  let WIDTH  = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height - 50

  let labelFont     = UIFont.boldSystemFontOfSize(30)
  let buttonFont    = UIFont.systemFontOfSize(30)
  let scoreFont     = UIFont.boldSystemFontOfSize(150)
  let scoreListFont = UIFont.systemFontOfSize(40)
  let highScoreFont = UIFont.boldSystemFontOfSize(30)

  let FACEBOOK_TEXT = "I scored big in Watch the Corners! Try and beat me!"
  let TWITTER_TEXT  = "I scored big in #watchthecorners! Try and beat me!"

  let TWITTER_APP_URL: NSURL = NSURL(string: "https://itunes.apple.com/app/apple-store/id978732428?pt=96139182&ct=Twitter&mt=8")!
  let FACEBOOK_APP_URL: NSURL = NSURL(string: "https://itunes.apple.com/app/apple-store/id978732428?pt=96139182&ct=Facebook&mt=8")!

  var scoresAsText   = ""
  var numberOfScores = 0

  var highScore: Int!

  var newScoreText: UILabel     = UILabel()
  var scoreLabel: UILabel       = UILabel()
  var highScoreText: UIButton   = UIButton.buttonWithType(.System) as! UIButton

  var gameScoreTextFrame: CGRect!
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

  func goToScores() {
    storage.synchronize()
    showViewController(scoresViewController(), sender: self)
  }


  func makeFrames() {
    logoFrame          = CGRectMake(10, 30, WIDTH, WIDTH/4)
    gameScoreTextFrame = CGRectMake(0, WIDTH/4 + 30, WIDTH, 60)
    gameScoreFrame     = CGRectMake(0, WIDTH/2, WIDTH, 160)
    highScoreTextFrame = CGRectMake(0, HEIGHT/2 + 90, WIDTH, 35)
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

    highScore = score.getHighScore()

    var topTenPercent    = Int(floor(0.9 * Float(highScore)))
    var bottomTenPercent = Int(floor(0.1 * Float(highScore)))

    if !score.duplicateScore {
      if score.currentScoreIsHighScore() && score.currentScore != 0 {
        score.reportToGameCenter()
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
        newScoreText.text      = "Almost There..."
        newScoreText.textColor = DARK_GRAY
        scoreLabel.textColor   = DARK_GRAY
      } else {
        newScoreText.text      = "Good Job!"
        newScoreText.textColor = LIGHT_GRAY
        scoreLabel.textColor   = LIGHT_GRAY
      }
    } else if (score.duplicateScore == true) {
      newScoreText.text      = "Better Luck Next Time!"
      newScoreText.textColor = DARK_GRAY
      scoreLabel.textColor   = DARK_GRAY
    }
  }

  func gameScoreText() {
    newScoreText.frame                     = gameScoreTextFrame
    newScoreText.textAlignment             = .Center
    newScoreText.font                      = labelFont
    newScoreText.adjustsFontSizeToFitWidth = true

    self.view.addSubview(newScoreText)
  }

  func highScoreLabels() {
    // A label to describe the high scores
    highScoreText.frame                     = highScoreTextFrame
    highScoreText.titleLabel?.font          = highScoreFont
    highScoreText.titleLabel?.textAlignment = .Center

    highScoreText.setTitle("High Score: \(score.getHighScore())", forState: .Normal)
    highScoreText.setTitleColor(DARK_GRAY, forState: .Normal)
    highScoreText.addTarget(self, action: Selector("goToScores"), forControlEvents: .TouchUpInside)

    self.view.addSubview(highScoreText)
  }

  func gameScoreLabel() {
    // The player's score from the completed game
    scoreLabel.text          = "\(score.currentScore)"
    scoreLabel.frame         = gameScoreFrame
    scoreLabel.textAlignment = .Center
    scoreLabel.font          = scoreFont

    self.view.addSubview(scoreLabel)
  }

  func playAgainButton() {
    // The button to allow the player to start a new game
    let button                       = UIButton.buttonWithType(.System) as! UIButton
    button.frame                     = buttonFrame
    button.layer.cornerRadius        = 10
    button.backgroundColor           = GREEN
    button.titleLabel?.font          = buttonFont
    button.titleLabel?.textAlignment = .Center

    button.setTitle("Play Again", forState: UIControlState.Normal)
    button.setTitleColor(DARK_GRAY, forState: UIControlState.Normal)
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)

    // The button that shares to Facebook
    let facebookShare            = UIButton.buttonWithType(.Custom) as! UIButton
    facebookShare.frame          = facebookFrame

    facebookShare.setImage(UIImage(named: "facebook-logo"), forState: UIControlState.Normal)
    facebookShare.addTarget(self, action: Selector("shareToFacebook"), forControlEvents: .TouchUpInside)

    // The button that shares to Twitter
    let twitterShare                = UIButton.buttonWithType(.Custom) as! UIButton
    twitterShare.frame              = twitterFrame
    twitterShare.layer.cornerRadius = 5

    twitterShare.setImage(UIImage(named: "twitter-logo-white"), forState: UIControlState.Normal)
    twitterShare.addTarget(self, action: Selector("shareToTwitter"), forControlEvents: .TouchUpInside)

    self.view.addSubview(button)
    self.view.addSubview(facebookShare)
    self.view.addSubview(twitterShare)
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
      sharesheet.addURL(FACEBOOK_APP_URL)
      self.presentViewController(sharesheet, animated: true, completion: nil)
    }
  }

  func shareToTwitter() {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
      var sharesheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      sharesheet.setInitialText(TWITTER_TEXT)
      sharesheet.addImage(saveScreenshot(view))
      sharesheet.addURL(TWITTER_APP_URL)
      self.presentViewController(sharesheet, animated: true, completion: nil)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadDefaults()
    score.addScoreToHighScores(score.currentScore)
    saveDefaults()

    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
    self.canDisplayBannerAds            = true
    self.view.backgroundColor           = WHITE

    makeFrames()
    displayScores()

  }
}
