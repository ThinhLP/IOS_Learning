//
//  EventTableViewCell.swift
//  EventManagement
//
//  Created by Thinh Le Phuc on 4/4/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

protocol EventCellDelegate: class {
  func deleteRow(_ tableViewCell: UITableViewCell)
}

class EventTableViewCell: UITableViewCell {
  @IBOutlet weak var eventTitle: UILabel!
  weak var delegate: EventCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
        // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
  }
  
  @IBAction func deleteEvent(_ sender: UIButton) {
     delegate?.deleteRow(self)
  }
 

}
