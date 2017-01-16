//
//  Post.swift
//  iDev Social
//
//  Created by Siraj Zaneer on 12/31/16.
//  Copyright © 2016 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class Post: NSObject {

    var text: String = ""
    private var _postKey: String!
    var imageId: String?
    var image: UIImage?
    var user: String = ""
    var flag: Int = 0
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        
        
        if let text = dictionary["text"] as? String {
            self.text = text
        }
        
        if let imageId = dictionary["image"] as? String {
            self.imageId = imageId
            flag = 1
        }
        
        self.user = dictionary["user"] as! String
        
    }
    
}
