//
//  ViewController.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 6/29/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {

  let appDelegate = (UIApplication.shared.delegate) as! AppDelegate

  override func viewDidLoad() {
    super.viewDidLoad()
    requestEarthquakeData()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  enum JSONError: String, Error {
    case NoData = "Error: No Data"
    case ConversionFailed = "Error: Conversion from JSON failed"
  }

  func requestEarthquakeData() {
    if let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson") {
      let request = NSMutableURLRequest(url: url)

      URLSession.shared.dataTask(with: request as URLRequest) {
        (data, response, error) in
          if error != nil {
            os_log("request failed to complete", type: .error)
            print(error as Any)
          } else  {
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print(json)
          }

        }.resume()
    }
  }


}

