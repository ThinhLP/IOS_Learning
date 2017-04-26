//
//  AddEventViewController.swift
//  EventManagementV2
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

protocol AddEventViewControllerDelegate: class {
  func addEventToArray(event: Event)
}

class AddEventViewController: UIViewController {
  @IBOutlet weak var eventDate: UILabel!
  @IBOutlet weak var eventTitleTextField: UITextField!
  @IBOutlet weak var eventContentTextView: UITextView!
  
  weak var delegate: AddEventViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set default date
    let formatDate = DateFormatter()
    formatDate.dateFormat = "dd-MM-yyyy"
    eventDate.text = formatDate.string(from: Date())
    // Customize text view
    customizeTextView()
    // Customize navigation
    customizeNavigation()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Customize text view
  func customizeTextView() {
    eventContentTextView.layer.borderColor = UIColor.lightGray.cgColor
    eventContentTextView.layer.borderWidth = 0.5
    eventContentTextView.layer.cornerRadius = 5
  }
  
  // MARK: - Customize navigation
  func customizeNavigation() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.addEvent))
  }
  
  // MARK: - Process when click Add button on navigation bar
  func addEvent() {
    guard let title = eventTitleTextField.text, let content = eventContentTextView.text, !title.isEmpty && !content.isEmpty else {
      return
    }
    // Add event to array
    let event = Event(title: title, content: content)
    delegate?.addEventToArray(event: event)
    // Back to previous view
    _ = self.navigationController?.popViewController(animated: true)
    
  }
  
}
