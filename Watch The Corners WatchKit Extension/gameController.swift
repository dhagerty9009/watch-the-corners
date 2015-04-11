//
//  InterfaceController.swift
//  Watch The Corners WatchKit Extension
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import WatchKit
import Foundation


class gameController: WKInterfaceController {

  // Color constants
  let WHITE: UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor = UIColor.blackColor()
  let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  // Time Constants
  let TIME_INTERVAL: NSTimeInterval = 10
  let ONE_SECOND: NSTimeInterval = 1

  // Game data
  let score = Score.sharedInstance
  var minuteTimer: NSTimer!
  var secondTimer: NSTimer!
  var board:GameBoard!
  var gameTimeLeft: Int!

  // Game data outlets
  @IBOutlet weak var scoreLabel: WKInterfaceLabel!
  @IBOutlet weak var gameTimer: WKInterfaceLabel!

  // The game's buttons
  @IBOutlet weak var buttonOne: WKInterfaceButton!
  @IBOutlet weak var buttonTwo: WKInterfaceButton!
  @IBOutlet weak var buttonThree: WKInterfaceButton!
  @IBOutlet weak var buttonFour: WKInterfaceButton!

  // End Game Enum
  enum EndGameReason {
    case TimeOut
    case WrongButton
  }
  var endGameReason = EndGameReason.TimeOut

  // Button Tapped
  var tapped = 5
  // 5 = error

  // Event handlers for all the buttons.
  @IBAction func TapOne() {
    tappedButton(1)
  }
  @IBAction func TapTwo() {
    tappedButton(2)
  }
  @IBAction func TapThree() {
    tappedButton(3)
  }
  @IBAction func TapFour() {
    tappedButton(4)
  }

  func tappedButton(button: Int) {
    var button = button
    var active = board.activeButton
    if button == active {
      score.currentScore = score.currentScore + 1
      if score.currentScore % 10 == 0 {
        gameTimeLeft = gameTimeLeft + Int(TIME_INTERVAL)
        secondTimer.invalidate()
        minuteTimer.invalidate()
        setTimer()
      }
      scoreLabel.setText("\(score.currentScore)")
      board.makeRandomButtonActive()
      activateButton(board.activeButton)
    } else {
      endGameReason = EndGameReason.WrongButton
      gameOver()
    }
  }

  func setTimer() {
    let TIME = NSTimeInterval(gameTimeLeft)
    minuteTimer = NSTimer.scheduledTimerWithTimeInterval(TIME, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    secondTimer = NSTimer.scheduledTimerWithTimeInterval(ONE_SECOND, target: self, selector: Selector("updateLabel"), userInfo: nil, repeats: true)
  }
  // This function changes the color of a button depending on whether it is the active button or not.
  func activateButton(button: Int) {
    buttonOne.setBackgroundColor(GRAY)
    buttonTwo.setBackgroundColor(GRAY)
    buttonThree.setBackgroundColor(GRAY)
    buttonFour.setBackgroundColor(GRAY)
    var newButton = button
    switch newButton {
    case 1:
      buttonOne.setBackgroundColor(GREEN)
    case 2:
      buttonTwo.setBackgroundColor(GREEN)
    case 3:
      buttonThree.setBackgroundColor(GREEN)
    case 4:
      buttonFour.setBackgroundColor(GREEN)
    default:
      break
    }
  }

  func updateLabel() {
    gameTimer.setText("\(gameTimeLeft - 1)")
    gameTimeLeft = gameTimeLeft - 1
  }
  // This is the game timer, started when the player pushes the start button.
  func startGame() {
    score.currentScore = 0
    gameTimeLeft = Int(TIME_INTERVAL)
    setTimer()
    board = GameBoard()
    activateButton(board.activeButton)
  }

  // A game over function to return the app to the initial state
  func gameOver() {
    gameTimer.setText("0")
    var endGameText: String = ""
    secondTimer.invalidate()
    minuteTimer.invalidate()
    // What to do for each reason the game was ended
    switch endGameReason{
    case .WrongButton:
      endGameText = "wrong button"
      switch tapped{
      case 1:
        buttonOne.setBackgroundColor(RED)
      case 2:
        buttonTwo.setBackgroundColor(RED)
      case 3:
        buttonThree.setBackgroundColor(RED)
      case 4:
        buttonFour.setBackgroundColor(RED)
      default:
        break
      }
    case .TimeOut:
      endGameText = "time out"
      buttonOne.setBackgroundColor(RED)
      buttonTwo.setBackgroundColor(RED)
      buttonThree.setBackgroundColor(RED)
      buttonFour.setBackgroundColor(RED)
    }

    NSLog("End Game Reason : \(endGameText)")

    NSLog("Game over: score was \(score.currentScore)")

    var waitTimer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("toResults"), userInfo: nil, repeats: false)
  }

  func toResults() {
    pushControllerWithName("resultController", context: nil)
  }

  // The default initialization function
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    startGame()
  }
}
