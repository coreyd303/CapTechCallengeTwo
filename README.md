# CapTech Challenge Two (Swift / iOS)
CapTech code challenge number 2

#### 1. Assignment
_This assignment, the second in the series, will familiarize the student with HTTP based network communications and XML parsing on the target platform. This assignment can be done for iOS, Android, mobile web, or any combination thereof._

##### The application must do the following:

* Retrieve historical earthquake data from the U.S. Geological Survey (USGS) and produce a table displaying information about earthquakes that have occurred in the past 30 days. The recommended approach section has a URL for the data.
* The view of earthquake events must be sorted in descending date order.
* Each item must display the following information in a pleasing and easy to read format:
  * The USGS title for the quake
  * The latitude and longitude of the quake
  * The time the quake occurred in local time

* The user must be able to force a reload of the view.
* When the user reloads the view, the server should be re-queried and the view reloaded with all quake data received from the server.
* The user must be able to selectively delete table items using a gesture familiar to uses of that platform.
* If the user selects a row the app should open an internal web browser control (native only) with a link to the full quake information at the USGS site.
* The items with an earthquake of magnitude 5 or higher must be shaded in light red.
* The items with a quake of magnitude 7 or higher must be shaded in red.
* The application must cleanly and correctly handle network failures or the absence of a network.
* The application must display some indicator that the application is busy during data loads.
* The application UI must remain responsive to user input during the data load process.
* The application must not crash or leak memory.
* The structure of the application must be well structured and understandable.
* If you’re completing this task using the mobile web technology, there may be no server side logic other than delivery of HTML/JS/CSS content to the phone. All other logic, storage, etc. must occur on the phone itself.

#### 2. Assignment Prerequisites

_[Assignment #1](https://github.com/coreyd303/CapTechChallengeOne) of the mobile development boot camp should be completed before starting this assignment._

#### 3. Assignment Objectives

_When completed the student should have an understanding of the following concepts:_

* HTTP request and response handling
* JSON parsing
* String manipulation
* Display theming and modifications including custom table rows
* Table row manipulation

#### 4. Recommended Approach
*  Data feed: http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson http://earthquake.usgs.gov/earthquakes/catalogs/

* Web resources:
  * http://www.raywenderlich.com/51127/nsurlsession-tutorial
  * http://www.raywenderlich.com/50317/beginning-auto-layout-tutorial-in-ios-7-part-1 o http://www.raywenderlich.com/83130/beginning-auto-layout-tutorial-swift-part-2

* Required Tools:
  * XCode 6.4 +
  * Mac with OS X 10.6
  * Assignment can be written in Swift or Objective C. If Swift, be sure to use Swift 1.2 orhigher

* Suggested APIs
  * UITableCellView, Use Self-Sizing Table View Cells o UITableViewController
  * NSURLSession
  * NSXMLParser

#### 3. Getting started

1. Open xcode and start a new project as a single page application
2. Initialize git from the project directory with _git init_
3. Create a gitHub repo for this project
  * Add your project to your new repo

#### 4. Extension Challenges
-- TBD --