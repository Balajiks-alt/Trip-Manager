//
//  ExpensesTableViewCell.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 15/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class ExpensesTableViewCell: UITableViewCell {
   


    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(expense: Expense){
        expenseNameLabel.text = expense.type
        expenseAmountLabel.text = String(expense.amount!)
    }
}
