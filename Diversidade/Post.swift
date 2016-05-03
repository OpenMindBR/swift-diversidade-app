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
    let date: String?
    let text: String?
    
    init(title: String, date:String, text: String) {
        self.title = title
        self.date  = date
        self.text  = text
    }
}
