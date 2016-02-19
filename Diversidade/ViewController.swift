//
//  ViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 19/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let revealController = self.revealViewController(){
            menuButton.target = revealController
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

