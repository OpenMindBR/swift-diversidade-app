//
//  BusinessHour.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 07/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class Horary: NSObject{
    let day: String
    let time: String
    
    init(day: String, time: String){
        self.day = day
        self.time  = time
    }
    
    override var description: String {
        return "\(self.day) \n \(self.time)"
    }
    
}
