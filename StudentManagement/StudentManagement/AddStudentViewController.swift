//
//  AddStudentViewController.swift
//  StudentManagement
//
//  Created by Thinh Le Phuc on 4/10/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

protocol AddStudentViewControllerDelegate: class {
  func addStudentToList(student: Student)
}

class AddStudentViewController: UIViewController {
  @IBOutlet weak var studentNameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var universityTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
 
  var textFieldPosition: CGFloat = 0.0
  var textFieldHeight: CGFloat = 0.0
  weak var delegate: AddStudentViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Customize Description text view
    customizeTextView()
    // Customize navigation
    customizeNavigation()
    // Change keyboard type
    ageTextField.keyboardType = UIKeyboardType.numberPad
    // Add observer
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    // Textfield delegate
    studentNameTextField.delegate = self
    ageTextField.delegate = self
    universityTextField.delegate = self
    descriptionTextField.delegate = self
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    // Remove observer after view disappear
    NotificationCenter.default.removeObserver(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
 
  // MARK: - Customize text view
  func customizeTextView() {
    descriptionTextField.layer.borderColor = UIColor.lightGray.cgColor
    descriptionTextField.layer.borderWidth = 0.5
    descriptionTextField.layer.cornerRadius = 5
  }
  
  // MARK: - Customize navigation
  func customizeNavigation() {
    self.navigationItem.title = "Add student"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(self.saveStudent))
  }
  
  // Process before keyboard is showed
  func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      let heightDevice = self.view.frame.height
      let keyboardPosition = heightDevice - keyboardSize.height
  
      // Do nothing when content is located under keyboard
      if textFieldPosition < keyboardPosition{
        return
      }
      // Move view to top

      if self.view.frame.origin.y == 0 {
        self.view.frame.origin.y -= (textFieldPosition - keyboardPosition + textFieldHeight)
      }
      
    }
  }
  
  // Process before keyboard is hidden
  func keyboardWillHide(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      let heightDevice = self.view.frame.height
      let keyboardPosition = heightDevice - keyboardSize.height
      // Do nothing when content is located under keyboard
      if textFieldPosition < keyboardPosition{
        return
      }
      // Move to initial position
      if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
      }
    }
  }
  
  // MARK: - Save student to list
  func saveStudent() {
    guard let name = self.studentNameTextField.text,
        let age = Int(self.ageTextField.text!),
        let university = self.universityTextField.text,
        let description = self.descriptionTextField.text,
        !name.isEmpty && !university.isEmpty && !description.isEmpty && age > 0 else {
      return
    }
    // Add student to list
    let newStudent = Student(name: name, university: university, age: age, description: description)
    delegate?.addStudentToList(student: newStudent)
    // Back to list view controller
    _ = self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - Process for UITextField Delegate
extension AddStudentViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    textFieldPosition = textField.frame.origin.y
    textFieldHeight = textField.frame.height
    return true
  }
}

