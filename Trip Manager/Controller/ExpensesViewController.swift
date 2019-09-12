//
//  ExpensesViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 12/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    var myPickerView: UIPickerView!
    var pickerData = ["Transport","Stay","Lunch","Breakfast","Dinner","Snacks","Drinks","Miscellaneous"]
    var indexnumber: Int?
    
   
    @IBOutlet weak var expenseTypePicker: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        expenseTypePicker.delegate = self
        self.tableView.register(UINib.init(nibName: "ExpensesTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpensesCellId")
    }
    
    @IBAction func addButton(_ sender: Any) {
        let expense = Expense()
        expense.type = expenseTypePicker.text!
        expense.amount = Double(amountTextField.text!)
        GlobalValue.shared.expenseList.append(expense)
     //  expense.memberList = GlobalValue.shared.memberList
        tableView.reloadData()
        expenseTypePicker.text = ""
        amountTextField.text = ""
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
        self.expenseTypePicker.text = pickerData[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(expenseTypePicker)
    }
    func pickUp(_ textField : UITextField){
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        //Tool Bar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ExpensesViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ExpensesViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    @objc func doneClick() {
        expenseTypePicker.resignFirstResponder()
    }
    @objc func cancelClick() {
        expenseTypePicker.resignFirstResponder()
    }
}

extension ExpensesViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  GlobalValue.shared.expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expensevc:ExpensesTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ExpensesCellId", for: indexPath) as! ExpensesTableViewCell
        expensevc.setUp(expense: GlobalValue.shared.expenseList[indexPath.row])
        return expensevc
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let updateExpenseVC:UpdateExpenseViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateExpenseViewController") as! UpdateExpenseViewController
        indexnumber = indexPath.row
        updateExpenseVC.indexnumber = self.indexnumber
        updateExpenseVC.setUp(expense:GlobalValue.shared.expenseList[indexPath.row])
        self.navigationController?.pushViewController(updateExpenseVC, animated: true)
    }
}
    

