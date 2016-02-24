//
//  CentersViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class CentersViewController: UIViewController {

    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let revealController = self.revealViewController(){
            menuItem.target = revealController
            menuItem.action = "revealToggle:"
            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
