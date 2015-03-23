//
//  GameBoard.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/23/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import Foundation

class GameBoard {

  let BOARD_SIZE = 4

  var activeButton:Int!

  init() {
    makeRandomButtonActive()
  }

  // makes a random 'button' active
  func makeRandomButtonActive() {
    let number = Int(arc4random_uniform(4)+1)
    self.activeButton = number
  }

}
