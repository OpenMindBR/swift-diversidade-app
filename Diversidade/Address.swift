//
//  Address.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 07/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Address: NSObject {
    
    let line1: String
    let number: String
    let neighborhood: String
    let city: String
    let region: String
    let zip: String
    
    init(line1: String, number:String, neighborhood: String, city: String, region: String, zip: String) {
        self.line1  = line1
        self.number = number
        self.neighborhood = neighborhood
        self.city   = city
        self.region = region
        self.zip = zip
    }
    
    override var description: String {
        return "\(self.line1), \(self.number), \(self.neighborhood) \n \(self.city) - \(self.region)"
    }
}
