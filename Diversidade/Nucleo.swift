//
//  Nucleo.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 07/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Nucleo: NSObject {
    
    let name: String
    let phone: String
    let email: String
    let urlSite: String
    
    var address: Address?
    var services: [Service]?
    var horary: [Horary]?
    
    init(name: String, phone: String, email: String, urlSite: String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.urlSite = urlSite
    }

}
