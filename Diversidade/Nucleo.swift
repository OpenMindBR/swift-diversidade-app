//
//  Nucleo.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 07/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import CoreLocation

class Nucleo: NSObject {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D

    var phone: String?
    var email: String?
    var urlSite: String?
    
    var address: Address?
    var services: [Service]?
    var horary: [Horary]?
    
    init(id: String, name: String, phone: String, email: String, urlSite: String, xCoord:CLLocationDegrees , yCoord: CLLocationDegrees) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.urlSite = urlSite
        self.coordinate = CLLocationCoordinate2D(latitude: xCoord, longitude: yCoord)
    }
    
    init(id: String, name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.name = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

}
