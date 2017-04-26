//
//  ViewController.swift
//  CalculateQuadraticEquation
//
//  Created by Thinh Le Phuc on 4/4/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var aTextField: UITextField!
  @IBOutlet weak var bTextField: UITextField!
  @IBOutlet weak var cTextField: UITextField!
  @IBOutlet weak var result: UILabel!
  @IBOutlet weak var extraResult: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Show error when user input incorrectly
  func setError() {
    result.textColor = UIColor.red
    result.text = "Field must be number!"
    extraResult.text = ""
  }
  
  // Show message when equation has infinity solutions or no solution
  func setMessageResult(msg: String) {
    result.textColor = UIColor.black
    result.text = msg
    extraResult.text = ""
  }
  
  // Show solutions of equation
  func setResult(_ x1: Double,_ x2: Double) {
    result.textColor = UIColor.black
    // Equation has 1 solution
    if (x1 == x2) {
      result.text = "Equation has a solution: x = \(x1)"
      extraResult.text = ""
    } else {
      // Equation has 2 solutions
      result.text = "Solutions: x1 = \(x1)"
      extraResult.text = "x2 = \(x2)"
    }
  }
  
  // Calculate equation when user click butotn
  @IBAction func calculate(_ sender: UIButton) {
    // Validate input
    guard let a = Double(aTextField.text!), let b = Double(bTextField.text!), let c = Double(cTextField.text!) else {
      setError()
      return
    }
    // Process
    if (a == 0 && b == 0 && c == 0) {
      setMessageResult(msg: "Equation has infinity solutions")
      return
    }
    let delta = b * b - 4 * a * c
    if (delta < 0) {
      setMessageResult(msg: "Equation has no solution")
      return
    }
    var x1: Double, x2: Double
    x1 = (-b + sqrt(delta)) / (2 * a)
    x2 = (-b - sqrt(delta)) / (2 * a)
    // Show result
    setResult(x1, x2)
    
  }

}

