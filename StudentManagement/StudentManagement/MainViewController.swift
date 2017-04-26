//
//  ViewController.swift
//  StudentManagement
//
//  Created by Thinh Le Phuc on 4/5/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var studentTableView: UITableView!
  var studentList: [Student] = []
  var filterStudent: [Student] = []
  var searchController: UISearchController!
  // Use as flag variable to know when user search student
  var shouldShowSearchResult = false
  // Use for storing data for passing another view controller
  var studentSource: Student?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
    // Customize navigation
    customizeNavigation()
    // Do any additional setup after loading the view, typically from a nib.
    studentTableView.dataSource = self
    // Create mock data
    createMockData()
    //Configure search controller
    configureSearchController()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Customize navigation
  func customizeNavigation() {
    self.navigationItem.title = "List"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.pushToAddStudentViewController))
  }
  // MARK: - Create mock data for business
  func createMockData() {
    studentList.append(Student(name: "ThinhLP", university: "FPT University", age: 20, description: "ThinhLP"))
    studentList.append(Student(name: "Ahihi", university: "FPT University", age: 25, description: "Ahihi"))
    studentList.append(Student(name: "Ahehe", university: "FPT University", age: 21, description: "Ahihi"))
  }

  // MARK: - Configure search controller
  func configureSearchController() {
    // Initialize and perform a minimum configuration to the search controller.
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    // Prevent background when searching, help user can interact with another component
    searchController.dimsBackgroundDuringPresentation = false
    // Prevent searchcontroller remains while search controller is active and user navigate to another view controller
    definesPresentationContext = true
    // Place the search bar view to the tableview headerview.
    studentTableView.tableHeaderView = searchController.searchBar
    // Init flag search variable
    shouldShowSearchResult = false
  }
  
  // MARK: - Prepare for segue, pass data to StudentDetail ViewController
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let cell = sender as? UITableViewCell, segue.identifier == Constants.studentViewDetailSegueID, let destination = segue.destination as? StudentDetailViewController, let indexPath = studentTableView.indexPath(for: cell) {
      // Pass data to Studen detail view controller
      destination.student = shouldShowSearchResult ? filterStudent[indexPath.row] : studentList[indexPath.row]
    }
  }
  
  // MARK: - Push to Add Student View Controller
  func pushToAddStudentViewController() {
    guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.addStudentViewControllerID) as? AddStudentViewController else {
      return
    }
    destinationVC.delegate = self
    self.navigationController?.pushViewController(destinationVC, animated: true)
  }
}

// MARK: - Process for TableView Data Source
extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shouldShowSearchResult && !searchController.searchBar.text!.isEmpty ? filterStudent.count : studentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.studentTableViewCellID , for: indexPath) as! StudentTableViewCell
    let student = shouldShowSearchResult ? filterStudent[indexPath.row] : studentList[indexPath.row]
    cell.studentNameLabel.text = student.name
    cell.descriptionLabel.text = student.description
    cell.universityLabel.text = student.university
    cell.ageLabel.text = "\(student.age) year olds"
    return cell
  }
}

// MARK: - Process for AddStudentViewController Delegate
extension MainViewController: AddStudentViewControllerDelegate {
  // Add new student to current list
  func addStudentToList(student: Student) {
    studentList.append(student)
    studentTableView.reloadData()
  }
}

// MARK: - Process for UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
  
  // Filter student by name
  func searchStudent(by name: String) {
    filterStudent = studentList.filter { student in
      return student.name.lowercased().contains(name.lowercased())
    }
    // Reload data of table view
    studentTableView.reloadData()
  }
  
  // Update search result when user is typing
  func updateSearchResults(for searchController: UISearchController) {
    let searchText = searchController.searchBar.text!
    // If seachtext is empty, then show all student, else show student of filter list
    shouldShowSearchResult = !searchText.isEmpty
    searchStudent(by: searchController.searchBar.text!)
  }
  
}


