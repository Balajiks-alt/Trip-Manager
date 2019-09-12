//
//  MembersViewTableViewCell.swift
//  Trip Manager
//
//  Created by Jotheeswari Ramasamy on 11/07/19.
//  Copyright © 2019 Jotheeswari Ramasamy. All rights reserved.
//

import UIKit


class MembersViewTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amounttLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(detail: Member){
        nameLabel.text = detail.name
        amounttLabel.text = String(detail.deposit!)
    }
    
    
}
