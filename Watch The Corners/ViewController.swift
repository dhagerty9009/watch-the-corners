//
//  ViewController.swift
//  Watch The Corners
//
//  Created by David Hagerty on 2/13/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var highScoreButton: UIButton!
  @IBOutlet weak var playGameButton: UIButton!

  let alertView: UIAlertView = UIAlertView.init(title:"Open in Watch to Play",
    message: "This app is to track high scores, the game is meant for the Watch.",
    delegate: nil,
    cancelButtonTitle: "Ok")

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func playGamePressed(sender: UIButton) {
    alertView.show()
  }

  @IBAction func goToHighScores(sender: UIButton) {
    showViewController(HighScoreTableViewController(), sender: highScoreButton)
  }


}

