//
//  EarthquakeDataManager.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 6/30/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import Foundation
import CoreData
import os.log

var sharedDataManager: EarthquakeDataManager?

class EarthquakeDataManager {

  class var shared : EarthquakeDataManager? {
    get {
      if (sharedDataManager == nil) {
        sharedDataManager = EarthquakeDataManager()
      }

      return(sharedDataManager)
    }
  }

  func requestEarthquakeData(completion: @escaping (Data?) -> ()) {
    if let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson") {
      let request = NSMutableURLRequest(url: url)

      URLSession.shared.dataTask(with: request as URLRequest) {
        (data, response, error) in
        if error != nil {
          os_log("request failed to complete", type: .error)
          print(error as Any)
          return completion(nil)
        } else  {
          return completion(data)
        }
        }.resume()
    }
  }
}
