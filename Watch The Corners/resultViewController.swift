//
//  resultViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {

  let WHITE: UIColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor = UIColor.blackColor()
  let GREEN: UIColor = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED : UIColor = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)

  let WIDTH = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height

  func backToGame() {
    showViewController(gameViewController(), sender: self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = WHITE

    var button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton

    button.frame = CGRectMake(WIDTH/2 - 50, HEIGHT/2 - 10, 100, 20)
    button.setTitle("It Worked!", forState: UIControlState.Normal)
    button.setTitleColor(GREEN, forState: UIControlState.Normal)
    button.addTarget(self, action: Selector("backToGame"), forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)
  }
}
