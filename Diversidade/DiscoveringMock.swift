//
//  DiscoveringMock.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 12/03/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import Foundation

class DiscoveringMock {
    
    static func mockDiscoveringData() -> [Post] {
        let post = Post(category: .Discovering, title: "Discovering Yourself", date: "12/12/12", text: "Theres some text here. http://www.facebook.com")
        
        return [post]
    }
    
    static func mockPlaces() -> [Nucleo]{
        let nucleo = Nucleo(name: "Some name", phone: "some phone", email: "some email", urlSite: "some url", xCoord: -3.741175, yCoord: -38.540062)
        
        return [nucleo]
    }
}