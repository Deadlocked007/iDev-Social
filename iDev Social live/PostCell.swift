//
//  PostCell.swift
//  iDev Social live
//
//  Created by Siraj Zaneer on 1/19/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
