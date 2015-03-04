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
  //let RED: UIColor = UIColor
  //let GREEN: UIColor = UIColor
  let GREY: UIColor = UIColor.grayColor()
  
  // Time Constants
  let MINUTE: NSTimeInterval = 60
  let UPDATE: NSTimeInterval = 15
  
  // Game data
  var random: NSNumber!
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
        addTimeToTimer()
      }
      scoreLabel.setText("Score: \(highScore)")
      board.makeRandomButtonActive()
      activateButton(board.activeButton)
    } else {
      gameOver()
    }
  }
  
  func addTimeToTimer() {
    minuteTimer.timeInterval + UPDATE
    NSLog("Timer now set for \(minuteTimer.timeInterval)")
    currentTime.dateByAddingTimeInterval(UPDATE)
    gameTimer.setDate(currentTime)
  }
  
  func activateButton(button: Int) {
    var newButton = button
    switch newButton {
    case 1:
      buttonOne.setBackgroundColor(WHITE)
      buttonTwo.setBackgroundColor(BLACK)
      buttonThree.setBackgroundColor(BLACK)
      buttonFour.setBackgroundColor(BLACK)
    case 2:
      buttonOne.setBackgroundColor(BLACK)
      buttonTwo.setBackgroundColor(WHITE)
      buttonThree.setBackgroundColor(BLACK)
      buttonFour.setBackgroundColor(BLACK)
    case 3:
      buttonOne.setBackgroundColor(BLACK)
      buttonTwo.setBackgroundColor(BLACK)
      buttonThree.setBackgroundColor(WHITE)
      buttonFour.setBackgroundColor(BLACK)
    case 4:
      buttonOne.setBackgroundColor(BLACK)
      buttonTwo.setBackgroundColor(BLACK)
      buttonThree.setBackgroundColor(BLACK)
      buttonFour.setBackgroundColor(WHITE)
    default:
      buttonOne.setBackgroundColor(BLACK)
      buttonTwo.setBackgroundColor(BLACK)
      buttonThree.setBackgroundColor(BLACK)
      buttonFour.setBackgroundColor(BLACK)
    }
  }
  
  // This is the game timer, started when the player pushes the start button.
  func startGame() {
    NSLog("Game started!")
    highScore = 0
    minuteTimer = NSTimer.scheduledTimerWithTimeInterval(MINUTE, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    currentTime = NSDate()
    currentTime.dateByAddingTimeInterval(MINUTE)
    gameTimer.setDate(currentTime)
    gameTimer.start()
    NSLog("Timer set for \(minuteTimer.timeInterval)")
    board = GameBoard()
    activateButton(board.activeButton)
  }

  // A game over function to return the app to the initial state
  func gameOver() {
    NSLog("Game over: score was \(highScore)")
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
