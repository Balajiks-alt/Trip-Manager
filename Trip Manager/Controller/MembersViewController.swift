//
//  MembersViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 11/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController,UITextFieldDelegate{
    
    var indexNumber: Int?
    var memberList = [Member]()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        amountTextField.delegate = self
        self.tableView.register(UINib.init(nibName: "MembersViewTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberCellId")
        
      
    }
   
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if nameTextField.text == "" && amountTextField.text == "" {
            nameTextField.layer.borderColor = UIColor.black.cgColor
            let alert = UIAlertController(title: nil, message: "Text Field Cannot be Empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
        } else {
            let member = Member()
            member.name = nameTextField.text!
            member.deposit = Double(amountTextField.text!)
            GlobalValue.shared.memberList.append(member)
            tableView.reloadData()
            nameTextField.text = ""
            amountTextField.text = ""
        }
        }
}


extension MembersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalValue.shared.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let membersvc:MembersViewTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MemberCellId", for: indexPath) as! MembersViewTableViewCell
        membersvc.tag = indexPath.row
        membersvc.setUp(detail: GlobalValue.shared.memberList[indexPath.row])
        return membersvc
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let updatemembervc:UpdateMemberViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateMemberViewController") as! UpdateMemberViewController
        indexNumber = indexPath.row
        updatemembervc.index = self.indexNumber
        updatemembervc.isAdd = true
        updatemembervc.delegate = self
        updatemembervc.setUpmember(member:GlobalValue.shared.memberList[indexPath.row])
        self.navigationController?.pushViewController(updatemembervc, animated: true)
    }
}
extension MembersViewController: UpdateMemberViewControllerDelegate{
    func updateButtonTapped(isAdd: Bool, member: Member, index: Int) {
        if isAdd{
            var expensearray = [GlobalValue.shared.expenseList]
            GlobalValue.shared.memberList.remove(at: index)
            GlobalValue.shared.memberList.insert(member, at: index)
            self.tableView.reloadData()
        }
        else{
            
            self.tableView.reloadData()
        }
    }
}

    
    



