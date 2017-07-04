//
//  HTTPClient.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 7/3/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import Foundation
import os.log

var sharedClient: HTTPClient?

class HTTPClient {

  class var shared : HTTPClient? {
    get {
      if (sharedClient == nil) {
        sharedClient = HTTPClient()
      }

      return(sharedClient)
    }
  }

  func requestEarthquakeData(completion: @escaping (Data?) -> ()) {
    if let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson") {
      let request = NSMutableURLRequest(url: url)

      URLSession.shared.dataTask(with: request as URLRequest) {
        (data, response, error) in
        if error != nil {
          os_log("request failed to complete", type: .error)
          return completion(nil)
        } else  {
          return completion(data)
        }
      }.resume()
    }
  }
}
