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

    dataManager.requestEarthquakeData() { data in
      if let data = data {
        self.parseJSON(data: data)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func parseJSON(data: Data) {
    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
    let theDataArray = json??["features"] as! NSArray

    let managedContext = coreDataStack.persistentContainer.viewContext

    for element in theDataArray {
      let asDict      = element as? NSDictionary
      let properties  = asDict?["properties"] as! NSDictionary
      let geometry    = asDict?["geometry"] as! NSDictionary
      let coordinates = geometry["coordinates"] as! NSArray
      let adjTime     = (properties["time"] as! Int) / 1000

      let theEarthquake  = Earthquake(context: managedContext)

      theEarthquake.title      = (properties["title"] as! String)
      theEarthquake.detailsURL = (properties["url"] as! String)
      theEarthquake.time       = Date(timeIntervalSince1970: TimeInterval(adjTime)) as NSDate
      theEarthquake.latitude   = coordinates[1] as! Double
      theEarthquake.longitude  = coordinates[0] as! Double


    }

    coreDataStack.saveContext()

  }
  
  @IBAction func imageAttribution(_ sender: Any) {

  }
  
}
