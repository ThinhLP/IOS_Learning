//
//  HistoryViewController.swift
//  TipCalculator
//
//  Created by Thinh Le Phuc on 4/12/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    var stardardUserDefault = UserDefaults.standard
    var historyList: [[String: Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Load history list from UserDefault
        historyList = stardardUserDefault.array(forKey: Constants.KeyUserDefault.historyList) as?  [[String: Double]] ??  [[String: Double]]()
        // History table view datasource
        historyTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: Process for TableViewDatasource
extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.historyTableViewCellID, for: indexPath) as! HistoryTableViewCell
        let history = historyList[indexPath.row]
        cell.billAmountLabel.text = "Bill amount: $\(history["bill"]!)"
        cell.tipLabel.text = "Tip: $\(history["tip"]!)"
        cell.totalLabel.text = "Total:  $ \(history["total"]!)"
        cell.tipPercentLabel.text = "Tip percent: \(history["tipPercent"]! * 100)%"
        return cell
    }
}
