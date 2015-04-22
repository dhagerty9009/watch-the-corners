//
//  GameButton.swift
//  Watch The Corners
//
//  Created by David Hagerty on 4/22/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import UIKit

enum GameButtonPosition {
  case TopLeftPosition
  case TopRightPosition
  case BottomLeftPosition
  case BottonRightPosition
}

class GameButton: UIButton {

  let WHITE: UIColor      = UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
  let BLACK: UIColor      = UIColor.blackColor()
  let GREEN: UIColor      = UIColor.init(red: 0.64, green: 0.83, blue: 0.63, alpha: 1)
  let GRAY: UIColor       = UIColor.init(red: 0.58, green: 0.59, blue: 0.6, alpha: 1)
  let RED: UIColor        = UIColor.init(red: 0.93, green: 0.34, blue: 0.34, alpha: 1)
  let TRUE_WHITE: UIColor = UIColor.whiteColor()

  let WIDTH = UIScreen.mainScreen().bounds.width
  let HEIGHT = UIScreen.mainScreen().bounds.height
  let HALF_WIDTH = UIScreen.mainScreen().bounds.width/2

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.backgroundColor = GRAY
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  override var highlighted: Bool {
    get {
      return super.highlighted
    }
    set {
      if newValue {
        backgroundColor = TRUE_WHITE
      } else {
        backgroundColor = backgroundColor
      }
      super.highlighted = newValue
    }
  }

}
