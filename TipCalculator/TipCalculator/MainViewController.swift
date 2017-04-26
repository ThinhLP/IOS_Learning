//
//  ViewController.swift
//  TipCalculator
//
//  Created by Thinh Le Phuc on 4/12/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //
    //billAmountTextField
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    
    var tipPercent: Double = 0
    var stardardUserDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Textfield configure
        billAmountTextField.keyboardType = .decimalPad
        // Customize navigation bar
        customizeNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        let percent = stardardUserDefault.double(forKey: Constants.KeyUserDefault.tipPercent)
        // Set default value of percent is 0.15 when user hasn't chosen tip percent
        if percent == 0 {
            setTipPercent(percent: 0.15)
        } else {
            setTipPercent(percent: percent)
        }
        // Reset field
        setResult(tips: 0, total: 0)
        billAmountTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Customize navigation bar
    func customizeNavigation() {
        self.navigationItem.title = "Calculator"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting", style: .done, target: self, action: #selector(self.navigateToSettingViewController))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "History", style: .done, target: self, action: #selector(self.navigateToHistoryViewController))
    }
    
    // MARK: - Navigate to Setting View Controller
    func navigateToSettingViewController() {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constants.settingViewControllerID)
        billAmountTextField.resignFirstResponder()
        self.navigationController?.pushViewController(destination!, animated: true)
    }
    
    // MARK: - Navigate to Setting View Controller
    func navigateToHistoryViewController() {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constants.historyViewControllerID)
        billAmountTextField.resignFirstResponder()
        self.navigationController?.pushViewController(destination!, animated: true)
    }

    // MARK: - Set tip percent
    func setTipPercent(percent: Double) {
        tipPercent = percent
        tipPercentLabel.text = "\(percent * 100)%"
    }
    
    // MARK: - Show calculate's results
    func setResult(tips: Double, total: Double) {
        tipLabel.text = "$ \(tips)"
        totalBillLabel.text = "$ \(total)"
    }

    // MARK: - Calculate money when click "Calculate" button
    @IBAction func calculateBill(_ sender: UIButton) {
        // Valid input from user
        guard let bill =  Double(billAmountTextField.text!) else {
            // Clear result when input wrong
            setResult(tips: 0, total: 0)
            return
        }
        // Process when user input number correctly
        let tips = bill * tipPercent
        let total = bill + tips
        // Show result
        setResult(tips: tips, total: total)
        // Save to history
        let dict = ["bill": bill, "tipPercent": tipPercent, "tip": tips, "total": total]
        // Get current history list from userdefault
        var historyList = stardardUserDefault.array(forKey: Constants.KeyUserDefault.historyList) as?  [[String: Double]] ??  [[String: Double]]()
        // Add history and set new history list to userdefault
        historyList.append(dict)
        stardardUserDefault.set(historyList, forKey: Constants.KeyUserDefault.historyList)
    }
    
    
}


