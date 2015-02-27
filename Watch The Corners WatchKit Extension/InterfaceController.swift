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
  
  let WHITE: UIColor = UIColor.whiteColor()
  let BLACK: UIColor = UIColor.blackColor()
  
  var random: NSNumber!
  var highScore: Int!
  
  @IBOutlet weak var label: WKInterfaceLabel!
  @IBOutlet weak var gameTimer: WKInterfaceTimer!
  
  @IBOutlet weak var buttonOne: WKInterfaceButton!
  @IBOutlet weak var buttonTwo: WKInterfaceButton!
  @IBOutlet weak var buttonThree: WKInterfaceButton!
  @IBOutlet weak var buttonFour: WKInterfaceButton!
  @IBOutlet weak var startButton: WKInterfaceButton!
  
  func randomNumber() -> NSNumber {
    let number = Int(arc4random_uniform(4)+1)
    return number
  }
  
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
  
  func setActive(button:WKInterfaceButton) {
    button.setBackgroundColor(WHITE)
    button.setTitle("Active")
    button.setEnabled(true)
  }
  
  func setInactive(button:WKInterfaceButton) {
    button.setBackgroundColor(BLACK)
    button.setTitle("Inactive")
    button.setEnabled(false)
  }
  
  func tapActions() {
    highScore = highScore + 1
    label.setText("Score: \(highScore)")
    random = randomNumber()
    makeButtonActive(random)
  }
  
  @IBAction func startTimer() {
    random = randomNumber()
    makeButtonActive(random)
    startButton.setEnabled(false)
  }
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
  
  func tapTimer() {
    
  }

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Disable all buttons initially.
    buttonOne.setEnabled(false)
    buttonTwo.setEnabled(false)
    buttonThree.setEnabled(false)
    buttonFour.setEnabled(false)
    highScore = 0
    label.setText("No Score")
  }
}
