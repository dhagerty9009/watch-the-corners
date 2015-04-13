//
//  rulesViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 4/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit
import QuartzCore

let WHITE: UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
let BLACK: UIColor = UIColor.blackColor()
let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
let DARK_GRAY: UIColor = UIColor.init(red: 0.18, green: 0.19, blue: 0.2, alpha: 1)
let LIGHT_GRAY: UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

let WIDTH = UIScreen.mainScreen().bounds.width
let HALF_WIDTH = UIScreen.mainScreen().bounds.width/2
let HEIGHT = UIScreen.mainScreen().bounds.height
let HALF_HEIGHT = UIScreen.mainScreen().bounds.height/2

let labelFont = UIFont.boldSystemFontOfSize(25)

class rulesViewController: UIViewController {
  
  var testButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
  
  var rulesLabel: UILabel = UILabel()
  
  var scoreRulesLabel: UILabel = UILabel()
  
  var extraTimeLabel: UILabel = UILabel()
  
  func makeButtons() {
    testButton.frame = CGRectMake(WIDTH/4, 30, WIDTH/2, WIDTH/2)
    testButton.backgroundColor = GREEN
    testButton.addTarget(self, action: Selector("testTapped"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(testButton)
    
    rulesLabel.frame = CGRectMake(0, HALF_WIDTH + 40, WIDTH, 30)
    rulesLabel.font = labelFont
    rulesLabel.text = "Tap the GREEN button."
    rulesLabel.textAlignment = NSTextAlignment.Center
    rulesLabel.textColor = DARK_GRAY
    self.view.addSubview(rulesLabel)
  }
  
  func testTapped() {
    rulesLabel.text = "Good Job!"
    testButton.enabled = false
    testButton.backgroundColor = LIGHT_GRAY
    
    var waitTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("scoreRules"), userInfo: nil, repeats: false)
    
  }
  
  func scoreRules() {
    scoreRulesLabel.text = "Try to get as many points as you can in TEN seconds."
    scoreRulesLabel.font = labelFont
    scoreRulesLabel.frame = CGRectMake(10, HALF_HEIGHT-75, WIDTH-20, 180)
    scoreRulesLabel.textAlignment = NSTextAlignment.Center
    scoreRulesLabel.textColor = DARK_GRAY
    scoreRulesLabel.numberOfLines = 3
    scoreRulesLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    self.view.addSubview(scoreRulesLabel)
    
    var waitTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("extraTimeRules"), userInfo: nil, repeats: false)
  }
  
  func extraTimeRules() {
    extraTimeLabel.text = "Every TEN points, you get TWO extra seconds."
    extraTimeLabel.font = labelFont
    extraTimeLabel.frame = CGRectMake(10, HALF_HEIGHT + 20, WIDTH - 20, 180)
    extraTimeLabel.textAlignment = NSTextAlignment.Center
    extraTimeLabel.textColor = DARK_GRAY
    extraTimeLabel.numberOfLines = 3
    extraTimeLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    self.view.addSubview(extraTimeLabel)
    
    var waitTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("playGame"), userInfo: nil, repeats: false)
  }
  
  func playGame() {
    rulesLabel.text = "Tap the button to play."
    rulesLabel.textColor = RED
    testButton.backgroundColor = GREEN
    testButton.enabled = true
    testButton.addTarget(self, action: Selector("goToGame"), forControlEvents: UIControlEvents.TouchUpInside)
  }
  
  func goToGame() {
    showViewController(gameViewController(), sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = WHITE
    makeButtons()
    
  }
}
