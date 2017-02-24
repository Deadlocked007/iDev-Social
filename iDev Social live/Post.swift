//
//  Post.swift
//  iDev Social live
//
//  Created by Siraj Zaneer on 1/19/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class Post: NSObject {

    var text: String = ""
    var email: String = ""
    var imageUUID: String?
    
    init(dictionary: Dictionary<String, AnyObject>) {
        guard let text = dictionary["text"] as? String else {
            return
        }
        
        self.text = text
        
        guard let email = dictionary["user"] as? String else {
            return
        }
        
        self.email = email
        
        guard let imageUUID = dictionary["image"] as? String else {
            return
        }
        
        self.imageUUID = imageUUID
    }
}
