//
//  AnnouncementTableViewCell.swift
//  Westview App
//
//  Created by Ronak Shah on 6/8/17.
//  Copyright © 2017 Ronak Shah. All rights reserved.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
