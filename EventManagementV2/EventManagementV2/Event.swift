//
//  Event.swift
//  EventManagementV2
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class Event {
  var eventDate: Date
  var eventTitle: String
  var eventContent: String
  
  func getDateString() -> String {
    let formatDate = DateFormatter()
    formatDate.dateFormat = "dd-MM-yyyy"
    return formatDate.string(from: self.eventDate)
  }
  
  init(strDate:String, title:String, content: String) {
    let formatDate = DateFormatter()
    formatDate.dateFormat = "dd-MM-yyyy"
    if let date = formatDate.date(from: strDate) {
      self.eventDate = date
    } else {
      self.eventDate = Date()
    }
    self.eventTitle = title
    self.eventContent = content
  }
  
  init(title:String, content: String)  {
    self.eventDate = Date()
    self.eventTitle = title
    self.eventContent = content
  }
}
