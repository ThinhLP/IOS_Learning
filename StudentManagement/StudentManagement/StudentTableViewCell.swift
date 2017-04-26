//
//  StudentTableViewCell.swift
//  StudentManagement
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
  @IBOutlet weak var studentNameLabel: UILabel!
  @IBOutlet weak var universityLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var studentImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
  }

}
