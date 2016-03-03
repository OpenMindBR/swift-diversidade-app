//
//  Post.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 03/03/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Post {
    let category: String?
    let title: String?
    let date: String?
    let text: String?
    
    init(category: String, title: String, date:String, text: String) {
        self.category = category
        self.title = title
        self.date  = date
        self.text  = text
    }
}
