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
  var mostRecentScore: Int!
  var highScores = [0, 0, 0, 0, 0]
  var duplicateScore: Bool!

  func addScoreToHighScores(score: Int) {
    mostRecentScore = highScores[0]
    println("\(mostRecentScore), \(currentScore)")
    if currentScore != mostRecentScore {
      duplicateScore = false
      for (index, storedScore) in enumerate(highScores) {
        if score > storedScore {
          var saved = storedScore
          highScores.removeAtIndex(index)
          highScores.insert(score, atIndex: index)
          if index + 1 != 5 {
            highScores.insert(saved, atIndex: index + 1)
          }
          highScores.removeLast()
          break
        }
      }
    } else if currentScore == mostRecentScore {
      duplicateScore = true
    }
  }

  func getHighScore() -> Int {
    return highScores[0]
  }


  func currentScoreIsHighScore() -> Bool {
    if currentScore == highScores[0] {
      return true
    } else {
      return false
    }
  }

  func reportToGameCenter() {
    GCHelper.reportLeaderboardIdentifier("1", score: currentScore)
  }


}

