//
//  Score.swift
//  Watch The Corners
//
//  Created by David Hagerty on 3/25/15.
//  Copyright (c) 2015 TwistSix, LLC. All rights reserved.
//

import Foundation

/** Score Class

*/
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

  var value: Int!

}
