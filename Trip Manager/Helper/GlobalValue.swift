//
//  GlobalValue.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 16/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import Foundation
class GlobalValue
    
{
    static var shared : GlobalValue = GlobalValue()
    var tripList = [Trip]()
    var memberList = [Member]()
    var expenseList = [Expense]()
    var totalExpense : Double?
    var totalDeposit: Double?
    var tripname: String?
    var expenseamount: Double?
    var expenseAmountPerHead: Double?
    var isText: Bool?
    var isCustomize = false
}



