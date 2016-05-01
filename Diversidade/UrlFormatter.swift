//
//  UrlFormatter.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 30/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

enum Category: String {
    case Discovering = "discovering"
    case Health = "health"
    case Rights = "rights"
}

class UrlFormatter {
    
    static func urlForCentersWithState(state: String) -> String {
        return "http://diversidade-cloudsocial.rhcloud.com/api/v1/centers?state=\(state)"
    }

    static func urlForCenterDetailsWithId(id: String) -> String {
        return "http://diversidade-cloudsocial.rhcloud.com/api/v1/centers/\(id)"
    }
    
    static func urlForNewsFromCategory(category: Category) -> String {
        return "http://diversidade-cloudsocial.rhcloud.com/api/v1/news/categories/\(category)"
    }
}
