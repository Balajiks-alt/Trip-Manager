//
//  TabBarViewController.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 12/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        self.tabBar.frame = CGRect(origin: CGPoint(x: 0, y: 70), size: CGSize(width: 440, height: 80))
    }
    func setUpname(trip: Trip){
        GlobalValue.shared.tripname = trip.name!
    }
}
