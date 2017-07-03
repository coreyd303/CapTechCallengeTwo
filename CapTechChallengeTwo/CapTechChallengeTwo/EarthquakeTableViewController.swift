//
//  EarthquakeTableViewController.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 6/30/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import UIKit

class EarthquakeTableViewController: UITableViewController {

  var earthquakes = [Earthquake]()

  var refresher: UIRefreshControl!

  let dataManager: EarthquakeDataManager = EarthquakeDataManager.shared!

  override func viewDidLoad() {
    super.viewDidLoad()

    let mapButton : UIBarButtonItem = UIBarButtonItem(title: "USGS Map", style: UIBarButtonItemStyle.plain, target: self, action: #selector(EarthquakeTableViewController.openMap))
    self.navigationItem.rightBarButtonItem = mapButton

    refresher = UIRefreshControl()
    refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refresher.addTarget(self, action: #selector(EarthquakeTableViewController.refreshData), for: UIControlEvents.valueChanged)
    tableView.addSubview(refresher!)

    updateDataArray()
  }

  func openMap() {
    performSegue(withIdentifier: "mapViewSegue", sender: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return earthquakes.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
    let quake = earthquakes[indexPath.row]

    cell.titleLabel?.text = "\(quake.title!)"
    cell.dateLabel?.text = String(describing: quake.time)
    cell.latLngLabel?.text = "Location: \(quake.latitude), \(quake.longitude)"

    if quake.magnitude > 0.0 {
      switch quake.magnitude {
      case _ where quake.magnitude >= 4.0:
        cell.titleLabel?.textColor = UIColor.FlatColor.Red.MildSauce
      case _ where quake.magnitude >= 2.5:
        cell.titleLabel?.textColor = UIColor.FlatColor.Red.HotTomato
      default:
        break
      }
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let url = NSURL(string: earthquakes[indexPath.row].detailsURL!) {
      UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
  }

  func updateDataArray() {
    let managedContext = coreDataStack.persistentContainer.viewContext

    do {
      let result = try managedContext.fetch(Earthquake.fetchRequest())
      let array = result as! [Earthquake]

      earthquakes = array.sortByDate()

      print("worked \(earthquakes.count)")
    } catch {
      print("Error")
    }
  }


  func refreshData(_ refreshControl: UIRefreshControl) {
      self.dataManager.requestEarthquakeData() { data in
        if let data = data {
          self.dataManager.parseJSON(data: data, shouldUpdateRecords: true)
        } else {
          let alert = UIAlertController(title: "Network Error",
                                        message: "We were unable to retrive the data, please check your network connection and try again",
                                        preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
      }

    updateDataArray()
    tableView.reloadData()
    refreshControl.endRefreshing()
  }


  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      earthquakes.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

}

