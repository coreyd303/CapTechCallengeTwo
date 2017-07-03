//
//  Earthquake+CoreDataClass.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 7/3/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import Foundation
import MapKit

class EarthquakeAnnotation: NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let locationName: String?

  init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
    self.locationName = locationName
    self.title = title

    super.init()
  }
}
