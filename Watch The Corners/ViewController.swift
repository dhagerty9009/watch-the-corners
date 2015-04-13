//
//  ViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var playGameButton: UIButton!

  @IBOutlet weak var highScoreButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func goToHighScores(sender: UIButton) {
    showViewController(resultViewController(), sender: self)
  }
  
  @IBAction func playGamePressed(sender: UIButton) {
    showViewController(gameViewController(), sender: self)
  }

}

