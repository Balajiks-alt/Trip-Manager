//
//  ReportsTableViewCell.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 17/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

var totalRefund: Double? = 0
var owesTotal: Double? = 0

class ReportsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memDeposit: UILabel!
    @IBOutlet weak var refundOutlet: UILabel!
    @IBOutlet weak var owesOutlet: UILabel!
    @IBOutlet weak var expensePerHead: UILabel!
    var expenseperHead : Double?
    var refund: Double? = 0
    var unspentOwes: Double? = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expenseperHead = Double((GlobalValue.shared.totalExpense!)) / Double((GlobalValue.shared.memberList.count))
        unspentOwes! = (GlobalValue.shared.totalDeposit!) - (GlobalValue.shared.totalExpense!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUp(member: Member)
    {
        memberName.text = member.name
        memDeposit.text = String(member.deposit!)
        expensePerHead.text = String(expenseperHead!)
        refund! = Double(member.deposit!) - Double(expenseperHead!)
        if(refund! < 0)
        {
            owesTotal! += refund!
            refundOutlet.text = "0"
            owesOutlet.text = String(refund!)
        }
        else{
            refundOutlet.text = String(refund!)
            owesOutlet.text = "0"
            totalRefund! += refund!
        }
    }
    
    func setupUnspent() {
        memberName.text = "UNSPENT"
        memDeposit.text = ""
        owesOutlet.text = String(unspentOwes!)
    }
    
    func setupTotal() {
        memberName.text = "TOTALS"
        memDeposit.text = ""
        expensePerHead.text = String(GlobalValue.shared.totalExpense!)
        refundOutlet.text = String(totalRefund!)
        owesTotal! = -(owesTotal!) + unspentOwes!
        owesOutlet.text = String(owesTotal!)
    }
}
