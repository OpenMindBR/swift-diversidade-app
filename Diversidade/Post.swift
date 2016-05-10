//
//  Post.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 03/03/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Post {
    
    let title: String?
    let url: String?
    let text: String?
    
    init(title: String, url:String, text: String) {
        self.title = title
        self.url   = url
        self.text  = text
    }
}
