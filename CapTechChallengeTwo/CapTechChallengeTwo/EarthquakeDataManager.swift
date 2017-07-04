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

  let managedContext = coreDataStack.persistentContainer.viewContext

  func clearEarthquakeData() {
    do {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Earthquake")
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      let result = try managedContext.execute(request)
      print(result)
    } catch {
      print("Error deleting records")
    }
  }

  func parseJSON(data: Data, shouldUpdateRecords: Bool = false) {
    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
    let theDataArray = json??["features"] as! NSArray

    for element in theDataArray {
      let asDict      = element as? NSDictionary
      let properties  = asDict?["properties"] as! NSDictionary
      let geometry    = asDict?["geometry"] as! NSDictionary
      let coordinates = geometry["coordinates"] as! NSArray
      let adjTime     = (properties["time"] as! Int) / 1000

      if(shouldUpdateRecords) {
        do {
          let title = properties["title"] as! String
          let thePredicate = NSPredicate(format: "title == %@", title)
          var request : NSFetchRequest<NSFetchRequestResult>? = nil
          request = NSFetchRequest<NSFetchRequestResult>(entityName: "Earthquake")
          request?.predicate = thePredicate
          let result = try managedContext.fetch(request!)

          if(result.count == 0) {
            creatyDataEntity(properties: properties, adjTime: adjTime, coordinates: coordinates)
          }
        } catch {
          os_log("Records failed to return", type: .error)
        }
      } else {
        creatyDataEntity(properties: properties, adjTime: adjTime, coordinates: coordinates)
      }
    }

    coreDataStack.saveContext()
    
  }

  func creatyDataEntity(properties: NSDictionary, adjTime: Int, coordinates: NSArray) {
    let theEarthquake  = Earthquake(context: managedContext)

    theEarthquake.title      = properties["title"] as? String
    theEarthquake.detailsURL = properties["url"] as? String
    theEarthquake.time       = Date(timeIntervalSince1970: TimeInterval(adjTime)) as NSDate
    theEarthquake.latitude   = coordinates[1] as! Double
    theEarthquake.longitude  = coordinates[0] as! Double
    if let magnitude = properties["mag"] as? Double {
      theEarthquake.magnitude  = magnitude
    }
  }

}
