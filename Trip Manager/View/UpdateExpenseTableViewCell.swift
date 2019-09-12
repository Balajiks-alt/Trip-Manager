//
//  UpdateExpenseTableViewCell.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 17/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

protocol UpdateExpenseTableViewCellDelegate {
    func updateMemberDetails(index:Int, member:Member)
    func updateExpenseDetails(index: Int, member: Member)
}
class UpdateExpenseTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var expenseAmountTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!
    
    var member = Member()
    var delegate: UpdateExpenseTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        expenseAmountTextField.text = ""
        checkboxButton.setImage(UIImage(named : "checked"), for: UIControl.State.normal)
        expenseAmountTextField.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func expenseAmountTextFieldDidEndEditing(_ sender: UITextField) {
        member.sharedAmount = Double(expenseAmountTextField.text!)
        self.delegate?.updateExpenseDetails(index: self.tag, member: self.member)
    }
    
    @IBAction func checkedButton(_ sender: Any) {
        self.member.isSelected = !self.member.isSelected
        self.delegate?.updateMemberDetails(index:self.tag, member:self.member)
    }
    
    func unSelectMember() {
        checkboxButton.setImage(UIImage(named : "unchecked"), for: UIControl.State.normal)
        expenseAmountTextField.text = ""
        expenseAmountTextField.isUserInteractionEnabled = false
    }
    
    func selectMember() {
        checkboxButton.setImage(UIImage(named : "checked"), for: UIControl.State.normal)
        if GlobalValue.shared.isCustomize == true
        {
            expenseAmountTextField.isUserInteractionEnabled = true
        }
        else
        {
            expenseAmountTextField.isUserInteractionEnabled = false
        }
        
        
    }
    
    func setUpMemberDetail(member: Member) {
        self.member = member
        memberNameLabel.text = member.name
        if member.isSelected {
            self.selectMember()
        }else {
            self.unSelectMember()
        }
        if member.sharedAmount! > 0.0 {
            expenseAmountTextField.text = String(member.sharedAmount!)
        }
    }
    }
