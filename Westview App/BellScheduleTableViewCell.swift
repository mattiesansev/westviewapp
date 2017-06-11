//
//  BellScheduleTableViewCell.swift
//  Westview App
//
//  Created by Ronak Shah on 6/10/17.
//  Copyright © 2017 Ronak Shah. All rights reserved.
//

import UIKit

class BellScheduleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var mid: UILabel!
    @IBOutlet weak var right: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
