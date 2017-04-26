//
//  EventDetailViewController.swift
//  EventManagementV2
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
  @IBOutlet weak var eventDate: UILabel!
  @IBOutlet weak var eventTitle: UILabel!
  @IBOutlet weak var eventContent: UILabel!
  var storedEvent: Event?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Customize navigation 
    self.navigationItem.title = "Event Details"
    // Set detail of event
    setDetailOfEvent()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Set detail of event to labels of view controller
  func setDetailOfEvent() {
    guard let event = self.storedEvent else {
      return
    }
    eventDate.text = event.getDateString()
    eventTitle.text = event.eventTitle
    eventContent.text = event.eventContent
  }
  

}
