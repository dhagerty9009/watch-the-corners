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
  
  // Game data
  var random: NSNumber!
  var highScore: Int!
  var minuteTimer: NSTimer!
  var currentTime: NSDate!
  var board:GameBoard!
  
  // Game data outlets
  @IBOutlet weak var label: WKInterfaceLabel!
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
    var active = board.activeButton
    if button == active {
      board.makeRandomButtonActive()
      activateButton()
      highScore = highScore + 1
    } else {
      gameOver()
    }
  }
  
  func activateButton() {
    var newButton = board.activeButton
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
    highScore = 0
    minuteTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: gameTimer, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    currentTime = NSDate()
    currentTime.dateByAddingTimeInterval(60)
    gameTimer.setDate(currentTime)
    gameTimer.start()
    board = GameBoard()
    activateButton()
  }
  
  // This function will fake incorrect taps by the user. It is a short timer that runs
  // the game over function whenever it stops.
  // A game over function to return the app to the initial state
  func gameOver() {
    gameTimer.stop()
    label.setText("Final Score: \(highScore)")
    minuteTimer = nil
    pushControllerWithName("mainController", context: highScore)
  }
  
  // The default initialization function
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    startGame()
  }
}
