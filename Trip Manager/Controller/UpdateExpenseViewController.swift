//
//  UpdateExpenseViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 17/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit
var updatedTotalExpense: Double?
class UpdateExpenseViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var myPickerView: UIPickerView!
    var pickerData = ["Transport","Stay","Lunch","Breakfast","Dinner","Snacks","Drinks","Miscellaneous"]
    var expenseamount: Double?
    var expenseTypeUpdate: String?
    var expenseAmountUpdate: Double?
    var expenseAmountPerHead: Double?
    var editExpenseAmount: Double?
    var indexnumber: Int?
    var expense = Expense()
    
    @IBOutlet weak var expensePickerType: UITextField!
    @IBOutlet weak var sharedButtonOutlet: UIButton!
    @IBOutlet weak var customizeButtton: UIButton!
    @IBOutlet weak var shareEvenlyButton: UIButton!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        expenseAmount.delegate = self
        expensePickerType.delegate = self
        self.tableView.register(UINib.init(nibName: "UpdateExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateExpenseCellId")
        expensePickerType.text = expenseTypeUpdate
        expenseAmount.text = String(expenseAmountUpdate!)
        GlobalValue.shared.expenseamount = Double(expenseAmount.text!)
        shareEvenlyButton.setImage(UIImage(named : "selectImage"), for: UIControl.State.normal)
        customizeButtton.setImage(UIImage(named : "deselectImage"), for: UIControl.State.normal)
        sharedButtonOutlet.isEnabled = true
        expense.memberList = GlobalValue.shared.memberList
        sharingEvenly()
    }
    func sharingEvenly()
    {
        for member in expense.memberList
        {
            member.sharedAmount = expenseAmountUpdate! / Double(expense.memberList.count)
        }
    }
    @IBAction func sharedEvenly(_ sender: Any) {
            GlobalValue.shared.isCustomize = false
            sharedButtonOutlet.isEnabled = true
            shareEvenlyButton.setImage(UIImage(named : "selectImage"), for: UIControl.State.normal)
            customizeButtton.setImage(UIImage(named : "deselectImage"), for: UIControl.State.normal)
            tableView.reloadData()
    }
  
    
    @IBAction func customize(_ sender: Any) {
            GlobalValue.shared.isCustomize = true
            sharedButtonOutlet.isEnabled = false
            customizeButtton.setImage(UIImage(named : "selectImage"), for: UIControl.State.normal)
            shareEvenlyButton.setImage(UIImage(named : "deselectImage"), for: UIControl.State.normal)
            tableView.reloadData()
    }
    
    
    @IBAction func updateDetails(_ sender: Any) {
        updatedTotalExpense = 0
     self.calculateTotalExpense()
        if expenseAmountUpdate == updatedTotalExpense{
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.alertTotalExpense()
        }
        
    }
    @IBAction func shareEvenly(_ sender: Any) {
        expenseAmountUpdate = Double(expenseAmount.text!)
        sharingEvenly()
        tableView.reloadData()
    }
    func calculateTotalExpense(){
        for member in expense.memberList
        {
            updatedTotalExpense! += member.sharedAmount!
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.expensePickerType.text = pickerData[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(expensePickerType)
        
        
    }
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UpdateExpenseViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(UpdateExpenseViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    @objc func doneClick() {
        expensePickerType.resignFirstResponder()
    }
    @objc func cancelClick() {
        expensePickerType.resignFirstResponder()
    }
 
    func setUp(expense: Expense){
        expenseTypeUpdate = expense.type!
        expenseAmountUpdate =  expense.amount!
    }
    func alertTotalExpense()
    {
        let alert = UIAlertController(title: nil, message: "Amount was not equally shared", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
        alert.addAction(ok)
        tableView.reloadData()
    }

}
extension UpdateExpenseViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expense.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let updateexpenseVC:UpdateExpenseTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "UpdateExpenseCellId", for: indexPath) as! UpdateExpenseTableViewCell
        updateexpenseVC.delegate = self
        updateexpenseVC.tag = indexPath.row
        updateexpenseVC.setUpMemberDetail(member: self.expense.memberList[indexPath.row])
        return updateexpenseVC
    }
}
extension UpdateExpenseViewController : UpdateExpenseTableViewCellDelegate
{
    func updateExpenseDetails(index: Int, member: Member) {
        if member.isSelected == false{
            self.expense.memberList.remove(at: index)
            self.expense.memberList.insert(member, at: index)
        }
       
        self.calculateShareForMemberInCustomize()
        
        self.tableView.reloadData()
    }
    
    func updateMemberDetails(index: Int, member:Member) {
    
        if member.isSelected == false{
            self.expense.memberList.remove(at: index)
            self.expense.memberList.insert(member, at: index)
        }
    
        self.calculateShareForMembers()
        
        self.tableView.reloadData()
    }
    func calculateShareForMemberInCustomize()
    {
        let selectedMembers = self.expense.memberList.filter { (member) -> Bool in
            return member.isSelected == true
        }
        if selectedMembers.count == 0
        {
            let alert = UIAlertController(title: nil, message: "CheckList Should not be empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
        }
        for member in self.expense.memberList {
            if member.isSelected == false {
                member.sharedAmount = 0
            }else{
            }
    }
    }
    func calculateShareForMembers() {
        let selectedMembers = self.expense.memberList.filter { (member) -> Bool in
            return member.isSelected == true
        }
        if selectedMembers.count == 0
        {
            let alert = UIAlertController(title: nil, message: "CheckList Should not be empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
        }
        let perMemberAmount = expenseAmountUpdate! / Double(selectedMembers.count)
      
        for member in self.expense.memberList {
            if member.isSelected == false {
                member.sharedAmount = 0
            }else{
                member.sharedAmount = perMemberAmount
            }
        }
    }
   
}

