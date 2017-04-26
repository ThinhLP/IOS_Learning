//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Thinh Le Phuc on 4/12/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var fivePercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var fifteenPercentButton: UIButton!
    var stardardUserDefault = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Process before view appear
    override func viewWillAppear(_ animated: Bool) {
        // Set current tip percent
        let index = stardardUserDefault.integer(forKey: Constants.KeyUserDefault.tipIndex)
        switch index {
        case 1:
            highlightButton(button: fivePercentButton)
        case 2:
            highlightButton(button: tenPercentButton)
        default:
            highlightButton(button: fifteenPercentButton)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set font size and color of label text of UIButton
    func setFontSizeAndColor(of button: UIButton, isActive: Bool) {
        let color = isActive ? UIColor.blue : UIColor.black
        button.setTitleColor(color, for: .normal)
    }
    
    // MARK: - Reset initial state of button
    func resetStateOfButton() {
        setFontSizeAndColor(of: fivePercentButton, isActive: false)
        setFontSizeAndColor(of: tenPercentButton, isActive: false)
        setFontSizeAndColor(of: fifteenPercentButton, isActive: false)

    }
    
    // MARK: - Highlight for button when clicked
    func highlightButton(button: UIButton) {
        // Reset state active of buttons
        resetStateOfButton()
        // Highlight active button
        setFontSizeAndColor(of: button, isActive: true)
       
       
    }
    
    // MARK: - Process when user choose 5% option
    @IBAction func chooseFivePercent(_ sender: UIButton) {
        highlightButton(button: fivePercentButton)
        stardardUserDefault.set(0.05, forKey: Constants.KeyUserDefault.tipPercent)
        stardardUserDefault.set(1, forKey: Constants.KeyUserDefault.tipIndex)
    }
    
    // MARK: - Process when user choose 10% option
    @IBAction func chooseTenPercent(_ sender: UIButton) {
        highlightButton(button: tenPercentButton)
        stardardUserDefault.set(0.10, forKey: Constants.KeyUserDefault.tipPercent)
        stardardUserDefault.set(2, forKey: Constants.KeyUserDefault.tipIndex)
    }
    
    // MARK: - Process when user choose 15% option
    @IBAction func chooseFifteenPercent(_ sender: UIButton) {
        highlightButton(button: fifteenPercentButton)
        stardardUserDefault.set(0.15, forKey: Constants.KeyUserDefault.tipPercent)
        stardardUserDefault.set(3, forKey: Constants.KeyUserDefault.tipIndex)
    }



}
