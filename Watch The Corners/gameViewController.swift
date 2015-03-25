//
//  gameViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import Foundation

class gameViewController: UIViewController {

  //Colors
  let WHITE: UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor = UIColor.blackColor()
  let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  // Game variables and constants
  var board: GameBoard!
  var score: Int!
  var gameTimer: NSTimer!
  var secondTimer: NSTimer!
  var timeLeft: Int!

  var scoreLabel: UILabel = UILabel()
  var gameTimerLabel: UILabel = UILabel()

  var buttonOne: UIButton!
  var buttonTwo: UIButton!
  var buttonThree: UIButton!
  var buttonFour: UIButton!

  let ONE_SECOND: NSTimeInterval = 1
  let TIME_INTERVAL: NSTimeInterval = 15

  let WIDTH = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height
  let HALF_WIDTH = UIScreen.mainScreen().bounds.width/2

  enum EndGameReason {
    case TimeOut
    case WrongButton
    case Error
  }
  var endGameReason = EndGameReason.Error

  /*
  This is the game logic. There will be timer functions, update functions, and all the
  other things a healthy, growing game needs.
  */

  func makeButtons() {
    // button one, top left corner
    buttonOne = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    buttonOne.frame = CGRectMake(0, 20, HALF_WIDTH, HALF_WIDTH)
    buttonOne.backgroundColor = GRAY
    buttonOne.tag = 1
    buttonOne.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(buttonOne)

    buttonTwo = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    buttonTwo.frame = CGRectMake(HALF_WIDTH, 20, HALF_WIDTH, HALF_WIDTH)
    buttonTwo.backgroundColor = GRAY
    buttonTwo.tag = 2
    buttonTwo.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(buttonTwo)

    buttonThree = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    buttonThree.frame = CGRectMake(0, HEIGHT-HALF_WIDTH, HALF_WIDTH, HALF_WIDTH)
    buttonThree.backgroundColor = GRAY
    buttonThree.tag = 3
    buttonThree.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(buttonThree)

    buttonFour = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    buttonFour.frame = CGRectMake(HALF_WIDTH, HEIGHT - HALF_WIDTH, HALF_WIDTH, HALF_WIDTH)
    buttonFour.backgroundColor = GRAY
    buttonFour.tag = 4
    buttonFour.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(buttonFour)
  }

  func makeLabels() {
    // this is the label for the score
    scoreLabel.frame = CGRectMake(0, HEIGHT/2, HALF_WIDTH, 60)
    scoreLabel.textColor = GREEN
    scoreLabel.textAlignment = NSTextAlignment.Left
    scoreLabel.text = "Score"
    self.view.addSubview(scoreLabel)
    // this is the label for the timer
    gameTimerLabel.frame = CGRectMake(HALF_WIDTH, HEIGHT/2, HALF_WIDTH, 60)
    gameTimerLabel.textColor = RED
    gameTimerLabel.textAlignment = NSTextAlignment.Right
    gameTimerLabel.text = "15"
    self.view.addSubview(gameTimerLabel)

  }

  func updateLabels() {
    gameTimerLabel.text = "\(timeLeft)"
    timeLeft = timeLeft - 1
  }

  func buttonTapped(sender: UIButton) {
    var button = sender.tag
    var active = board.activeButton
    if button == active {
      score = score + 1
      if score % 10 == 0 {
        timeLeft = timeLeft + Int(TIME_INTERVAL)
        invalidateTimers()
        setTimers()
      }
      scoreLabel.text = ("\(score)")
      board.makeRandomButtonActive()
      activateButton(board.activeButton)
    } else {
      endGameReason = EndGameReason.WrongButton
      gameOver()
    }
  }

  func activateButton(button: Int) {
    buttonOne.backgroundColor = GRAY
    buttonTwo.backgroundColor = GRAY
    buttonThree.backgroundColor = GRAY
    buttonFour.backgroundColor = GRAY
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

  func updateLabel() {
    gameTimerLabel.text = "\(timeLeft)"
    timeLeft = timeLeft - 1
  }

  func setTimers() {
    let TIME = NSTimeInterval(timeLeft)
    gameTimer = NSTimer.scheduledTimerWithTimeInterval(TIME, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    secondTimer = NSTimer.scheduledTimerWithTimeInterval(ONE_SECOND, target: self, selector: Selector("updateLabels"), userInfo: nil, repeats: true)
  }

  func invalidateTimers() {
    gameTimer.invalidate()
    secondTimer.invalidate()
  }

  func gameOver() {
    invalidateTimers()
    switch endGameReason {
    case .WrongButton:
      NSLog("Wrong button tapped")
    case .TimeOut:
      NSLog("Timer timed out")
      buttonOne.backgroundColor = RED
      buttonTwo.backgroundColor = RED
      buttonThree.backgroundColor = RED
      buttonFour.backgroundColor = RED
    case .Error:
      NSLog("Error!")
    default:
      NSLog("Game over")
    }
    sleep(2)
    toScoreScreen()
  }

  func toScoreScreen() {
    showViewController(resultViewController(), sender: self)
  }

  func startGame() {
    score = 0
    timeLeft = Int(TIME_INTERVAL) - 1
    setTimers()
    board = GameBoard()
    activateButton(board.activeButton)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = WHITE
    makeButtons()
    makeLabels()
    startGame()
  }

}