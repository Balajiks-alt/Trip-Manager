//
//  UpdateMemberViewController.swift
//  Trip Manager
//
//  Created by Balaji Sundaram on 18/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit
protocol UpdateMemberViewControllerDelegate{
    func updateButtonTapped(isAdd: Bool, member: Member,index: Int)
}
var additionalValue: Double? = 0


class UpdateMemberViewController: UIViewController {
    var isAdd: Bool?
    var member = Member()
    var index : Int?
    var delegate: UpdateMemberViewControllerDelegate?
    var memberList = [Member]()
    var memberName: String?
    var memberDeposit: Double?
    @IBOutlet weak var memberNameTextField: UITextField!
    @IBOutlet weak var memberDepositTextField: UITextField!
    @IBOutlet weak var additionalValueTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        memberNameTextField.text = memberName!
        memberDepositTextField.text = String(memberDeposit!)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        additionalValue = Double(additionalValueTextField.text!)
        memberDeposit! += additionalValue!
        memberDepositTextField.text = String(memberDeposit!)
    }
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        additionalValue = Double(additionalValueTextField.text!)
        memberDeposit! -= additionalValue!
        memberDepositTextField.text = String(memberDeposit!)
    }
    @IBAction func updateButtonTapped(_ sender: Any) {
       // let member = Member()
        self.member.name = memberNameTextField.text!
        self.member.deposit = Double(memberDepositTextField.text!)
        self.delegate?.updateButtonTapped(isAdd: self.isAdd!, member: self.member, index: self.index!)
        self.navigationController?.popViewController(animated: true)
    }

    func setUpmember(member: Member){
        memberName = member.name!
        memberDeposit = member.deposit!
    }
}
