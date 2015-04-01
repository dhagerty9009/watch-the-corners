//
//  Score.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/25/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import Foundation

class Score {

  class var sharedInstance : Score {
    struct Static {
      static var onceToken : dispatch_once_t = 0
      static var instance : Score? = nil
    }
    dispatch_once(&Static.onceToken) {
      Static.instance = Score()
    }
    return Static.instance!
  }

  var currentScore: Int!
  var highScores = [0, 0, 0, 0, 0]

  func addScoreToHighScores(score: Int) {
    for (index, storedScore) in enumerate(highScores) {
      if score > storedScore {
        var saved = storedScore
        highScores.removeAtIndex(index)
        highScores.insert(score, atIndex: index)
        if index + 1 != 5 {
          highScores.insert(saved, atIndex: index + 1)
        }
        if index + 1 == 5 {
          highScores.removeLast()
        }
        break
      }
    }
  }

  func currentScoreIsHighScore() -> Bool {
    if currentScore == highScores[0] {
      return true
    } else {
      return false
    }
  }
}

