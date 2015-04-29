//
//  gameViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class gameViewController: UIViewController {

  //Colors
  let WHITE:      UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK:      UIColor = UIColor.blackColor()
  let GREEN:      UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY:       UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED:        UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)
  let TRUE_WHITE: UIColor = UIColor.whiteColor()

  var buttonSound = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("blip2", ofType: "wav")!)
  var deathSound  = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("endgame", ofType: "wav")!)

  var buttonPlayer = AVAudioPlayer()
  var deathPlayer  = AVAudioPlayer()

  // Game variables and constants
  var board:       GameBoard!
  var gameTimer:   NSTimer!
  var secondTimer: NSTimer!
  var timeLeft:    Int!

  var scoreLabel:     UILabel = UILabel()
  var gameTimerLabel: UILabel = UILabel()
  var timeLabel:      UILabel = UILabel()

  var buttonOne:   GameButton!
  var buttonTwo:   GameButton!
  var buttonThree: GameButton!
  var buttonFour:  GameButton!

  let score = Score.sharedInstance

  let labelFont = UIFont.systemFontOfSize(50)

  let ONE_SECOND: NSTimeInterval = 1
  let TIME_INTERVAL: NSTimeInterval = 10
  let ADDITIONAL_TIME: NSTimeInterval = 2

  let WIDTH      = UIScreen.mainScreen().bounds.width
  let HEIGHT     = UIScreen.mainScreen().bounds.height
  let HALF_WIDTH = UIScreen.mainScreen().bounds.width/2

  enum EndGameReason {
    case TimeOut
    case WrongButton
  }
  var endGameReason: EndGameReason = .TimeOut

  func makeButtons() {
    buttonOne                   = GameButton.buttonWithType(UIButtonType.Custom) as! GameButton
    buttonOne.frame             = CGRectMake(0, 20, HALF_WIDTH, HALF_WIDTH)
    buttonOne.backgroundColor   = GRAY
    buttonOne.tag               = 1
    buttonTwo                   = GameButton.buttonWithType(UIButtonType.Custom) as! GameButton
    buttonTwo.frame             = CGRectMake(HALF_WIDTH, 20, HALF_WIDTH, HALF_WIDTH)
    buttonTwo.backgroundColor   = GRAY
    buttonTwo.tag               = 2
    buttonThree                 = GameButton.buttonWithType(UIButtonType.Custom) as! GameButton
    buttonThree.frame           = CGRectMake(0, HEIGHT-HALF_WIDTH, HALF_WIDTH, HALF_WIDTH)
    buttonThree.backgroundColor = GRAY
    buttonThree.tag             = 3
    buttonFour                  = GameButton.buttonWithType(UIButtonType.Custom) as! GameButton
    buttonFour.frame            = CGRectMake(HALF_WIDTH, HEIGHT - HALF_WIDTH, HALF_WIDTH, HALF_WIDTH)
    buttonFour.backgroundColor  = GRAY
    buttonFour.tag              = 4

    buttonOne.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
    buttonTwo.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
    buttonThree.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
    buttonFour.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
    self.view.addSubview(buttonOne)
    self.view.addSubview(buttonTwo)
    self.view.addSubview(buttonThree)
    self.view.addSubview(buttonFour)
  }

  func makeLabels() {
    scoreLabel.frame             = CGRectMake(10, HEIGHT/2, HALF_WIDTH - 10, 60)
    scoreLabel.textColor         = GREEN
    scoreLabel.textAlignment     = NSTextAlignment.Left
    scoreLabel.font              = labelFont
    scoreLabel.text              = "0"
    gameTimerLabel.frame         = CGRectMake(HALF_WIDTH, HEIGHT/2, HALF_WIDTH - 10, 60)
    gameTimerLabel.textColor     = RED
    gameTimerLabel.textAlignment = NSTextAlignment.Right
    gameTimerLabel.font          = labelFont
    gameTimerLabel.text          = "10"
    timeLabel.frame              = CGRectMake(0, HEIGHT/2, WIDTH, 60)
    timeLabel.textColor          = GRAY
    timeLabel.textAlignment      = NSTextAlignment.Center
    timeLabel.font               = labelFont
    timeLabel.text               = ""

    self.view.addSubview(scoreLabel)
    self.view.addSubview(gameTimerLabel)
    self.view.addSubview(timeLabel)

  }

  func updateLabels() {
    timeLabel.text      = ""
    gameTimerLabel.text = "\(timeLeft - 1)"
    timeLeft            = timeLeft - 1
  }

  func buttonTapped(sender: UIButton) {
    var button = sender.tag
    var active = board.activeButton

    if button == active {
      buttonPlayer.play()
      score.currentScore = score.currentScore + 1
      if score.currentScore % 10 == 0 {
        timeLabel.text = "+2"
        timeLeft       = timeLeft + Int(ADDITIONAL_TIME)
        invalidateTimers()
        setTimers()
      }
      scoreLabel.text = ("\(score.currentScore)")
      board.makeRandomButtonActive()
      activateButton(board.activeButton)
    } else {
      timeLabel.text = ""
      endGameReason  = .WrongButton
      sender.backgroundColor = RED
      gameOver()
    }
  }

  func activateButton(button: Int) {
    buttonOne.backgroundColor   = GRAY
    buttonTwo.backgroundColor   = GRAY
    buttonThree.backgroundColor = GRAY
    buttonFour.backgroundColor  = GRAY
    var pressed = button
    switch pressed {
    case 1:
      buttonOne.backgroundColor = GREEN
    case 2:
      buttonTwo.backgroundColor = GREEN
    case 3:
      buttonThree.backgroundColor = GREEN
    case 4:
      buttonFour.backgroundColor = GREEN
    default:
      break
    }
  }

  func setTimers() {
    let TIME    = NSTimeInterval(timeLeft)
    gameTimer   = NSTimer.scheduledTimerWithTimeInterval(TIME, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    secondTimer = NSTimer.scheduledTimerWithTimeInterval(ONE_SECOND, target: self, selector: Selector("updateLabels"), userInfo: nil, repeats: true)
  }

  func invalidateTimers() {
    gameTimer.invalidate()
    secondTimer.invalidate()
  }

  func gameOver() {
    // disable all interaction with buttons
    buttonOne.enabled   = false
    buttonTwo.enabled   = false
    buttonThree.enabled = false
    buttonFour.enabled  = false
    deathPlayer.play()

    gameTimerLabel.text = "0"
    invalidateTimers()
    switch endGameReason {
    case .WrongButton:
      NSLog("Wrong button tapped")
    case .TimeOut:
      NSLog("Timer timed out")
      buttonOne.backgroundColor   = RED
      buttonTwo.backgroundColor   = RED
      buttonThree.backgroundColor = RED
      buttonFour.backgroundColor  = RED
    default:
      NSLog("Something Went Wrong")
    }
    var waitTimer = NSTimer.scheduledTimerWithTimeInterval(ONE_SECOND*2, target: self, selector: Selector("toScoreScreen"), userInfo: nil, repeats: false)
  }

  func toScoreScreen() {
    showViewController(resultViewController(), sender: self)
  }

  func startGame() {
    score.currentScore = 0
    timeLeft = Int(TIME_INTERVAL)
    setTimers()
    board = GameBoard()
    activateButton(board.activeButton)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = WHITE
    buttonPlayer = AVAudioPlayer(contentsOfURL: buttonSound, error: nil)
    deathPlayer  = AVAudioPlayer(contentsOfURL: deathSound, error: nil)
    buttonPlayer.prepareToPlay()
    deathPlayer.prepareToPlay()
    makeButtons()
    makeLabels()
    startGame()
  }

}
