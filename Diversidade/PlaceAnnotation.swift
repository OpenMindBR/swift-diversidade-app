//
//  PlaceAnnotation.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 30/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let placeId: String
    let placeName: String
    let placeAddress: String
    let coordinate: CLLocationCoordinate2D
    
    init(placeId: String, placeName: String, placeAddress: String, coordinate: CLLocationCoordinate2D) {
        self.placeId = placeId
        self.placeName = placeName
        self.placeAddress = placeAddress
        self.coordinate = coordinate
        
        super.init()
    }
    
    var title: String? {
        return placeName
    }
    
    var subtitle: String? {
        return placeAddress
    }
}
