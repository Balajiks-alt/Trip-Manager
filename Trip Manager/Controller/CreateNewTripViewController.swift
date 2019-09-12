//
//  CreateNewTripViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 10/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

protocol CreateNewTripNameDelegate {
    func createTripAction(trip: Trip)
}

class CreateNewTripViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    
    var tripList = Trip()
    var delegate: CreateNewTripNameDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        daysTextField.delegate = self
        tripNameTextField.delegate = self
    }

    
    @IBAction func createTripAction(_ sender: Any) {
        if (tripNameTextField.text!.count == 0)
        {
            let alert = UIAlertController(title: nil, message: "Trip Name cannot be empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
        }
        else if (daysTextField.text!.count == 0)
        {
            let alert = UIAlertController(title: nil, message: "No of Days cannot be empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
            }
        else
        {
            self.tripList.name = tripNameTextField.text
            self.tripList.days = Int(daysTextField.text!)
            self.delegate?.createTripAction(trip: self.tripList)
            self.navigationController?.popViewController(animated: true)
        }
    }
}



