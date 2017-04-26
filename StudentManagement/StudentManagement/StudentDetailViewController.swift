//
//  StudentDetailViewController.swift
//  StudentManagement
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {
  @IBOutlet weak var studentNameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var universityLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var studentImageView: UIImageView!
  var student: Student?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Load detail of student after loading view successfully
    loadStudentDetail()
    // Customize navigation
    self.navigationItem.title = "Detail"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Load detail of student
  func loadStudentDetail() {
    if let student = self.student {
      studentNameLabel.text = student.name
      ageLabel.text = "\(student.age)"
      universityLabel.text = student.university
      descriptionLabel.text = student.description
    }
    
  }

}
