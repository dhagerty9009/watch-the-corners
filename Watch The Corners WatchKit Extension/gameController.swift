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
  let WHITE: UIColor = UIColor.whiteColor()
  let BLACK: UIColor = UIColor.blackColor()
  let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)
  
  // Time Constants
  let TIME_INTERVAL: NSTimeInterval = 15
  let ONE_SECOND: NSTimeInterval = 1
  
  // Game data
  var highScore: Int!
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
    case Error
  }
  var endGameReason = EndGameReason.Error
  
  // Button Tapped
  var tapped = 5
  // 5 = error
  
  // Event handlers for all the buttons.
  @IBAction func TapOne() {
    let buttonNumber = 1
    tappedButton(buttonNumber)
  }
  @IBAction func TapTwo() {
    let buttonNumber = 2
    tappedButton(buttonNumber)
  }
  @IBAction func TapThree() {
    let buttonNumber = 3
    tappedButton(buttonNumber)
  }
  @IBAction func TapFour() {
    let buttonNumber = 4
    tappedButton(buttonNumber)
  }
  
  func tappedButton(button: Int) {
    var button = button
    var active = board.activeButton
    if button == active {
      highScore = highScore + 1
      if highScore % 10 == 0 {
        gameTimeLeft = gameTimeLeft + Int(TIME_INTERVAL)
        secondTimer.invalidate()
        minuteTimer.invalidate()
        setTimer()
      }
      scoreLabel.setText("Score: \(highScore)")
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
    NSLog("Time left: \(gameTimeLeft)")
    gameTimer.setText("\(gameTimeLeft)s")
    gameTimeLeft = gameTimeLeft - 1
  }
  // This is the game timer, started when the player pushes the start button.
  func startGame() {
    NSLog("Game started!")
    highScore = 0
    gameTimeLeft = Int(TIME_INTERVAL)
    setTimer()
    board = GameBoard()
    activateButton(board.activeButton)
  }
  
  
  
  // A game over function to return the app to the initial state
  func gameOver() {
    var endGameText : String = ""
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
    case .Error:
      endGameText = "error"
    }
    
    NSLog("End Game Reason : \(endGameText)")
    
    NSLog("Game over: score was \(highScore)")
    
    toResults()
  }
  
  func toResults() {
    sleep(1)
    pushControllerWithName("resultController", context: highScore)
  }
  
  // The default initialization function
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    startGame()
  }
}
