//
//  ViewController.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 6/30/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let dataManager: EarthquakeDataManager = EarthquakeDataManager.shared!
    let client: HTTPClient = HTTPClient.shared!

    dataManager.clearEarthquakeData()
    client.requestEarthquakeData() { data in
      if let data = data {
        dataManager.parseJSON(data: data)
      } else {
        let alert = UIAlertController(title: "Network Error",
                                      message: "We were unable to retrive the data, please check your network connection and try again",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
    
  @IBAction func imageAttribution(_ sender: Any) {

  }
  
}
