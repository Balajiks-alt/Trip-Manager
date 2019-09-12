//
//  ManageTripViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 10/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit


class ManageTripViewController: UIViewController{
     var trip = Trip()
     var tripList = [Trip]()
    
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "ManageTripTableViewCell", bundle: nil), forCellReuseIdentifier: "CellId")
    }
}


extension ManageTripViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripList.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactListTVC:ManageTripTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ManageTripTableViewCell
        contactListTVC.tag = indexPath.row
        contactListTVC.setUp(trip: self.tripList[indexPath.row])
        return contactListTVC
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarvc:TabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabbarvc.setUpname(trip: self.tripList[indexPath.row])
        self.navigationController?.pushViewController(tabbarvc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tripList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
//    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
//
//        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
//            let touchPoint = longPressGestureRecognizer.location(in: self.view)
//            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
//                // add your code here
//                // you can use 'indexPath' to find out which row is selected
//            }
//        }
//    }
    
    // longTap
    
   
}

