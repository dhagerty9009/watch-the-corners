//
//  InterfaceController.swift
//  Watch The Corners WatchKit Extension
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  // Color constants
  let WHITE: UIColor = UIColor.whiteColor()
  let BLACK: UIColor = UIColor.blackColor()
  // Game data
  var random: NSNumber!
  var highScore: Int!
  var secondTimer: NSTimer!
  var minuteTimer: NSTimer!
  var currentTime: NSDate!
  // Game data outlets
  @IBOutlet weak var label: WKInterfaceLabel!
  @IBOutlet weak var gameTimer: WKInterfaceTimer!
  // The game's buttons
  @IBOutlet weak var buttonOne: WKInterfaceButton!
  @IBOutlet weak var buttonTwo: WKInterfaceButton!
  @IBOutlet weak var buttonThree: WKInterfaceButton!
  @IBOutlet weak var buttonFour: WKInterfaceButton!
  @IBOutlet weak var startButton: WKInterfaceButton!
  // Generates a random number
  func randomNumber() -> NSNumber {
    let number = Int(arc4random_uniform(4)+1)
    return number
  }
  // Sets a random button to be active, and deactivates the rest.
  func makeButtonActive(number:NSNumber) {
    switch number {
    case 1:
      setInactive(buttonFour)
      setInactive(buttonThree)
      setInactive(buttonTwo)
      setActive(buttonOne)
    case 2:
      setInactive(buttonFour)
      setInactive(buttonThree)
      setActive(buttonTwo)
      setInactive(buttonOne)
    case 3:
      setInactive(buttonFour)
      setActive(buttonThree)
      setInactive(buttonTwo)
      setInactive(buttonOne)
    case 4:
      setActive(buttonFour)
      setInactive(buttonThree)
      setInactive(buttonTwo)
      setInactive(buttonOne)
    default:
      setInactive(buttonFour)
      setInactive(buttonThree)
      setInactive(buttonTwo)
      setInactive(buttonOne)
    }
  }
  // This activates the passed button, making it tappable
  func setActive(button:WKInterfaceButton) {
    button.setBackgroundColor(WHITE)
    button.setTitle("")
    button.setEnabled(true)
  }
  // This deactivates the passed button, making it untappable.
  func setInactive(button:WKInterfaceButton) {
    button.setBackgroundColor(BLACK)
    button.setTitle("")
    button.setEnabled(false)
  }
  // These actions are called every time a button is tapped.
  func tapActions() {
    highScore = highScore + 1
    // If the high score is divisible by ten, add time to the game.
    if highScore % 10 == 0 {
      minuteTimer.timeInterval + 15
    }
    label.setText("Score: \(highScore)")
    random = randomNumber()
    makeButtonActive(random)
    secondTimer.timeInterval + 2 // destroy the previous timer so it doesn't go off by accident.
    tapTimer()
  }
  // This sets all game buttons - not the start button - to their default, inactive state.
  func disableAllButtons() {
    setInactive(buttonFour)
    setInactive(buttonThree)
    setInactive(buttonTwo)
    setInactive(buttonOne)
  }
  // This is the game timer, started when the player pushes the start button.
  @IBAction func startTimer() {
    random = randomNumber()
    makeButtonActive(random)
    startButton.setEnabled(false)
    minuteTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: gameTimer, selector: Selector("gameOver"), userInfo: nil, repeats: false)
    currentTime = NSDate()
    currentTime.dateByAddingTimeInterval(60)
    gameTimer.setDate(currentTime)
    gameTimer.start()
  }
  // Event handlers for all the buttons.
  @IBAction func TapOne() {
    tapActions()
  }
  @IBAction func TapTwo() {
    tapActions()
  }
  @IBAction func TapThree() {
    tapActions()
  }
  @IBAction func TapFour() {
    tapActions()
  }
  // This function will fake incorrect taps by the user. It is a short timer that runs
  // the game over function whenever it stops.
  func tapTimer() {
    secondTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("gameOver"), userInfo: nil, repeats: false)
  }
  // A game over function to return the app to the initial state
  func gameOver() {
    gameTimer.stop()
    label.setText("Final Score: \(highScore)")
    disableAllButtons()
    startButton.setEnabled(true)
  }
  // The default initialization function
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Disable all buttons initially.
    disableAllButtons()
    // Set the High Score to 0
    highScore = 0
    // Initially there is no score
    label.setText("No Score")
  }
}
