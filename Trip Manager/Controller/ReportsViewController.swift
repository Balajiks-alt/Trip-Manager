//
//  ReportsViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 12/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var totalMembersOutlet: UILabel!
    @IBOutlet weak var totalExpenseOutlet: UILabel!
    @IBOutlet weak var totalDepositsOutlet: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tripNameOutlet: UILabel!
    
    var tripname: String?
    
    override func viewDidLoad() {
        var totalDeposit: Double = 0
        var totalExpense: Double = 0

        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "ReportsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReportsCellId")
        tripNameOutlet.text = GlobalValue.shared.tripname!
        totalMembersOutlet.text = String(GlobalValue.shared.memberList.count)
       
        for trip in GlobalValue.shared.tripList
        {
            tripname = trip.name!
        }
        for member in GlobalValue.shared.memberList
        {
            totalDeposit += member.deposit!
        }
        for expense in GlobalValue.shared.expenseList
        {
            totalExpense += expense.amount!
        }
        
        totalDepositsOutlet.text = String(totalDeposit)
        totalExpenseOutlet.text = String(totalExpense)
        
        GlobalValue.shared.totalExpense = Double(totalExpense)
        GlobalValue.shared.totalDeposit = Double(totalDeposit)
     
   }
}


extension ReportsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalValue.shared.memberList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == GlobalValue.shared.memberList.count {
            let reportvc:ReportsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ReportsCellId", for: indexPath) as! ReportsTableViewCell
            //calculate unspent amount
            reportvc.setupUnspent()
            return reportvc
        }else if indexPath.row == GlobalValue.shared.memberList.count + 1 {
            let reportvc:ReportsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ReportsCellId", for: indexPath) as! ReportsTableViewCell
            //calculate total amount
            reportvc.setupTotal()
            return reportvc
        }else {
            let reportvc:ReportsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ReportsCellId", for: indexPath) as! ReportsTableViewCell
            reportvc.setUp(member: GlobalValue.shared.memberList[indexPath.row])
            return reportvc
        }
   }
}

    




