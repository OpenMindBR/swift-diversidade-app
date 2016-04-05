//
//  PlaceMaker.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 05/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMaker: GMSMarker {
    let place: GooglePlace
    
    init(place: GooglePlace){
        self.place  = place
        
        super.init()
        
        self.position = place.coordinate
        self.icon     = UIImage(named: "pin")
        self.groundAnchor    = CGPoint(x:0.5, y:1)
        self.appearAnimation = kGMSMarkerAnimationPop
    }
}
