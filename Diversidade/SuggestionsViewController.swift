//
//  SuggestionsViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController {

    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSideMenu(self.menuItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
