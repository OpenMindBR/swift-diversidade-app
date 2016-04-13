//
//  PlaceMarker.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 13/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
    let nucleo: Nucleo
    
    init(nucleo: Nucleo){
        self.nucleo = nucleo
        
        super.init()
        
        self.position = nucleo.location
        self.icon = UIImage(named: "pin")
        self.groundAnchor = CGPoint(x: 0.5, y: 1)
        self.appearAnimation = kGMSMarkerAnimationPop
        
    }
}
