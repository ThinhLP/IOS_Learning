//
//  EventDetailViewController.swift
//  EventManagement
//
//  Created by Thinh Le Phuc on 4/4/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
  @IBOutlet weak var eventDay: UILabel!
  @IBOutlet weak var eventContent: UILabel!
  var eventDayData: String?
  var eventContentData: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set data from previous view controller to labels
    setDataForLabels()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  // Set data for labels
  func setDataForLabels() {
    eventDay.text = eventDayData
    eventContent.text = eventContentData
  }
}
