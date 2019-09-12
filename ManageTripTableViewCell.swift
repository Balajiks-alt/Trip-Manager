//
//  ManageTripTableViewCell.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 10/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit



class ManageTripTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tripNameDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func  setUp(trip: Trip){
        self.tripNameDisplay.text = trip.name
    }
}
