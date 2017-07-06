//
//  EarthquakeDataManagerTests.swift
//  CapTechChallengeTwo
//
//  Created by Corey Davis on 7/5/17.
//  Copyright © 2017 Corey Davis. All rights reserved.
//

import XCTest
import os.log
@testable import CapTechChallengeTwo

class EarthquakeDataManagerTests: XCTest {
  var dataManager: EarthquakeDataManager!

  override func setUp() {
    dataManager = EarthquakeDataManager.shared!
  }

  func testDataManagerWillParseJSONObject() {
    if let file = Bundle.main.url(forResource: "Request", withExtension: "json") {
      do {
        let data = try Data(contentsOf: file)
        XCTAssertNoThrow(dataManager.parseAndSaveJSON(data: data), "JSON parse succeeds and does not throw")
      } catch {
        os_log("Error fetching data", type: .error)
      }
    }
  }
}
