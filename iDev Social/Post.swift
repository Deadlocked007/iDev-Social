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
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        
        if let text = dictionary["text"] as? String {
            self.text = text
        }
        
    }
    
}
