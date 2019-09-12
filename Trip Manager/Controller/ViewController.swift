//
//  ViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 10/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
   var tripList = [Trip]()
   
    @IBAction func createAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller:CreateNewTripViewController = storyBoard.instantiateViewController(withIdentifier: "CreateNewTripViewController") as! CreateNewTripViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func manageAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let manageTripVC:ManageTripViewController = storyBoard.instantiateViewController(withIdentifier: "ManageTripViewController") as! ManageTripViewController
        manageTripVC.tripList = self.tripList
        self.navigationController?.pushViewController(manageTripVC, animated: true)
    }
}

extension ViewController: CreateNewTripNameDelegate
{
    func createTripAction(trip: Trip) {
        self.tripList.append(trip)
    }
}


