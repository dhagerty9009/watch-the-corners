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
  var highScore: NSNumber!
  
  @IBOutlet weak var label: WKInterfaceLabel!
  
  @IBOutlet weak var buttonOne: WKInterfaceButton!
  @IBOutlet weak var buttonTwo: WKInterfaceButton!
  @IBOutlet weak var buttonThree: WKInterfaceButton!
  @IBOutlet weak var buttonFour: WKInterfaceButton!
  
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
      setActive(buttonOne)
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
  
  @IBAction func startTimer() {
    
  }
  @IBAction func TapOne() {
    label.setText("One was tapped.")
    random = randomNumber()
    makeButtonActive(random)
  }
  @IBAction func TapTwo() {
    label.setText("Two was tapped.")
    random = randomNumber()
    makeButtonActive(random)
  }
  @IBAction func TapThree() {
    label.setText("Three was tapped.")
    random = randomNumber()
    makeButtonActive(random)
  }
  @IBAction func TapFour() {
    label.setText("Four was tapped.")
    random = randomNumber()
    makeButtonActive(random)
  }

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    highScore = 0
    label.setText("Score: \(highScore)")
  }
}
