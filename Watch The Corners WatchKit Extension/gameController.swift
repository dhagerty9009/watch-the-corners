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
  let GREEN : UIColor = UIColor.greenColor()
  let GRAY : UIColor = UIColor.grayColor()
  let RED : UIColor = UIColor.redColor()
  
  // Time Constants
  let INTERVAL: NSTimeInterval = 15
  
  // Game data
  var highScore: Int!
  var minuteTimer: NSTimer!
  var currentTime: NSDate!
  var board:GameBoard!
  
  // Game data outlets
  @IBOutlet weak var scoreLabel: WKInterfaceLabel!
  @IBOutlet weak var gameTimer: WKInterfaceTimer!
  
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
    minuteTimer = NSTimer.scheduledTimerWithTimeInterval(INTERVAL, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    currentTime = NSDate()
    currentTime.dateByAddingTimeInterval(-INTERVAL)
    gameTimer.setDate(currentTime)
    gameTimer.start()
    
    //gameOver(EndGameReason.TimeOut, button: 1)
  }
  
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
  // This is the game timer, started when the player pushes the start button.
  func startGame() {
    NSLog("Game started!")
    highScore = 0
    setTimer()
    board = GameBoard()
    activateButton(board.activeButton)
  }
  
  
  
  // A game over function to return the app to the initial state
  func gameOver() {
    var endGameText : String = ""
    
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
  
    gameTimer.stop()
    minuteTimer.invalidate()
    pushControllerWithName("resultController", context: highScore)
  }
  
  // The default initialization function
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    startGame()
  }
}
