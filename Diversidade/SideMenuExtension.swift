//
//  SideMenuExtension.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureSideMenu(menuButton:UIBarButtonItem!){
        if let revealController = self.revealViewController(){
            menuButton.target = revealController
            menuButton.action = "revealToggle:"
            
            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
        }
    }
}
