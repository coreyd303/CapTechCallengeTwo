//
//  MapViewController.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 7/3/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!

  var earthquakes = [Earthquake]()

  override func viewDidLoad() {
    super.viewDidLoad()
    let managedContext = coreDataStack.persistentContainer.viewContext

    do {
      let result = try managedContext.fetch(Earthquake.fetchRequest())

      let elist = result as! [Earthquake]
      earthquakes = elist.biggestQuakesByMagnitude()

      print("worked \(earthquakes.count)")
    } catch {
      print("Error")
    }

    for quake in earthquakes {
      let coordinate = CLLocationCoordinate2D(latitude: quake.latitude, longitude: quake.longitude)
      let annotation = EarthquakeAnnotation(title: String(describing: quake.magnitude), locationName: quake.title!, coordinate: coordinate)
      mapView.addAnnotation(annotation)
    }
  }
}
