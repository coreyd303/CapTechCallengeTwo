//
//  ArrayEarthquake.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 7/3/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import Foundation

extension Array where Element: Earthquake {
  func sortByDate() -> [Earthquake] {
    var sortedArray: [Earthquake] = []

    sortedArray = self.sorted(by: {
      $0.time!.compare($1.time! as Date) == .orderedDescending
    })

    return(sortedArray)
  }

  func biggestQuakesByMagnitude() -> [Earthquake] {
    let quakes = self.filter({ $0.magnitude >= 3.0 })
    return quakes
  }
}
