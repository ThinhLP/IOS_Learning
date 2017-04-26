//
//  ViewController.swift
//  EventManagement
//
//  Created by Thinh Le Phuc on 4/4/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var eventTableView: UITableView!
  var eventList: [[String]] = []
  let dayOfWeek: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
    // Create mock data to use in tableview
    createMockData()
    // Table view delegate
    eventTableView.dataSource = self
    eventTableView.delegate = self
    // Custome navigation
    disableEditingModeOfTableView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Create mock data
  func createMockData() {
    for day in 0...6 {
      var list: [String] = []
      for i in 1...10 {
        list.append("\(dayOfWeek[day]) - Event \(i)")
      }
      eventList.append(list)
    }
  }
  
  // MARK: - Set status editing of table view
  func enableEditingModeOfTableView() {
    eventTableView.isEditing = true
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(disableEditingModeOfTableView))
  }
  
  func disableEditingModeOfTableView() {
    eventTableView.isEditing = false
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit"), style: UIBarButtonItemStyle.done, target: self, action: #selector(enableEditingModeOfTableView))
  }

}

// MARK: - Process for TableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventList[section].count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dayOfWeek[section]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Util.identifier["EventTableViewCell"]!, for: indexPath) as! EventTableViewCell
    cell.eventTitle.text = eventList[indexPath.section][indexPath.row]
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // Process when swipe left
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      eventList[indexPath.section].remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  // Use to move row in tableview
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // Move row
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let sourceSection = sourceIndexPath.section
    let sourceRow = sourceIndexPath.row
    let destinationSection = destinationIndexPath.section
    let destinationRow = destinationIndexPath.row
    // Get item want to move
    let itemMove = eventList[sourceSection][sourceRow]
    // Remove it from current position
    eventList[sourceSection].remove(at: sourceRow)
    // Add to new position
    eventList[destinationSection].insert(itemMove, at: destinationRow)
  }

}

// MARK: - Process for TableViewDelegate
extension ViewController: UITableViewDelegate {
  // Push to Event Detail Controller
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let eventDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: Util.identifier["EventDetailViewController"]!) as! EventDetailViewController
    let section = indexPath.section
    let row = indexPath.row
    // Pass data to detail controller
    eventDetailViewController.eventDayData = dayOfWeek[section]
    eventDetailViewController.eventContentData = eventList[section][row]
    self.navigationController?.pushViewController(eventDetailViewController, animated: true)
  }
}

// MARK: - Process for EventCellDelegate
extension ViewController: EventCellDelegate {
  func deleteRow(_ tableViewCell: UITableViewCell) {
    guard let indexPath = eventTableView.indexPath(for: tableViewCell) else {
      return
    }
    eventList[indexPath.section].remove(at: indexPath.row)
    eventTableView.deleteRows(at: [indexPath], with: .fade)
  }
  
}

