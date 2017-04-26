//
//  ViewController.swift
//  EventManagementV2
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
  @IBOutlet weak var eventCollectionView: UICollectionView!
  var eventList: [String : [Event]] = [:]
  var dateList: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //
    self.automaticallyAdjustsScrollViewInsets = false
    // Create mock data
    createMockData()
    // Delegate
    eventCollectionView.dataSource = self
    eventCollectionView.delegate = self
    // Customize navigation
    customizeNavigation()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Create mock data for business
  func createMockData() {
    createEvents(in: "03-04-2017", numOfEvent: 3)
    createEvents(in: "04-04-2017", numOfEvent: 7)
  }
  
  func createEvents(in date: String, numOfEvent: Int) {
    self.dateList.append(date)
    var eventInDay: [Event] = []
    if let list = self.eventList[date] {
      eventInDay = list
    }
    for i in 1...numOfEvent {
      let event = Event(strDate: date, title: "Event \(i)", content: "ahihi")
      eventInDay.append(event)
    }
    self.eventList[date] = eventInDay
  }
  
  // MARK: - Customize navigation 
  func customizeNavigation() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.pushToAddViewController))
  }
  
  // MARK: - Process when user click button "+" on navigation
  func pushToAddViewController() {
    let addEventViewController = self.storyboard?.instantiateViewController(withIdentifier: Util.addEventViewControllerID) as! AddEventViewController
    addEventViewController.delegate = self
    self.navigationController?.pushViewController(addEventViewController, animated: true)
  }
}

// MARK: - Collection View Datasource
extension MainViewController: UICollectionViewDataSource {
  // Set number of sections in Collection view
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return eventList.count
  }
  // Set number of items of a section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let list : [Event] = eventList[dateList[section]]!
    return list.count
  }
  
  // Customize cell of colletion view
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Util.eventCollectionViewCellID, for: indexPath) as! EventCollectionViewCell
    let list : [Event] = eventList[dateList[indexPath.section]]!
    cell.eventTitle.text = list[indexPath.row].eventTitle
    cell.backgroundColor = UIColor(red: 252/255, green: 199/255, blue: 159/255, alpha: 1)
    return cell
  }
  
  // Customize header of each section
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Util.headerCollectionReusableViewID, for: indexPath) as! HeaderCollectionReusableView
    header.dayOfEvents.text = dateList[indexPath.section]
    header.backgroundColor =  UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    return header
  }
  
  
}

// MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let section = indexPath.section
//    let row = indexPath.row
//    let list : [Event] = eventList[dateList[section]]!
//    let event = list[row]
//    // Get Event detail view controller
//    //let storyboard = UIStoryboard
//    let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: Util.eventDetailViewControllerID) as! EventDetailViewController
//    // Pass argument to detail view controller for business
//    detailViewController.storedEvent = event
//    // Push to detail view controller
//    self.navigationController?.pushViewController(detailViewController, animated: true)
//    
//  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let tmp = eventList[dateList[sourceIndexPath.section]]![sourceIndexPath.row]
    eventList[dateList[sourceIndexPath.section]]![sourceIndexPath.row] = eventList[dateList[destinationIndexPath.section]]![destinationIndexPath.row]
    eventList[dateList[destinationIndexPath.section]]![destinationIndexPath.row] = tmp
  }
}

// MARK: - Process for AddEventViewController Delegate 
extension MainViewController: AddEventViewControllerDelegate {
  func addEventToArray(event: Event) {
    var section = dateList.index(of: event.getDateString())
    if (section == nil) {
      dateList.append(event.getDateString())
      section = dateList.count - 1
    }
    var eventInDay: [Event] = []
    if let list = self.eventList[dateList[section!]] {
      eventInDay = list
    }
    eventInDay.append(event)
    eventList[dateList[section!]] = eventInDay
    eventCollectionView.reloadData()
  }
}
