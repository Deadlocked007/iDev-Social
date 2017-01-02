//
//  PostPCell.swift
//  iDev Social
//
//  Created by Siraj Zaneer on 1/1/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class PostPCell: UITableViewCell {
    
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
