//
//  Comment.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 07/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Comment {
    let username: String
    let date: String
    let text: String
    
    init(username: String, date: String, text: String) {
        self.username = username
        self.date = date
        self.text = text
    }
}
