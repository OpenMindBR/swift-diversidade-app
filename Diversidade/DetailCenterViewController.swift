//
//  DetailCenterViewController.swift
//  
//
//  Created by Francisco José A. C. Souza on 06/04/16.
//
//

import UIKit

class DetailCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var centerProfileImage: UIImageView!
    @IBOutlet weak var centerCoverPicture: UIImageView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var centerPhoneLabel: UILabel!
    
    @IBOutlet weak var optionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    var center: Nucleo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.centerNameLabel.text = center?.name
        self.centerPhoneLabel.text = center?.phone
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sections = 1
        
        if self.optionsSegmentedControl.selectedSegmentIndex == 0 {
            sections = 2
        }
        
        return sections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 0
        
        if optionsSegmentedControl.selectedSegmentIndex == 0 {
            rows = 2
        }
        else if optionsSegmentedControl.selectedSegmentIndex == 1 {
            
            if let center = self.center, let services = center.services {
                rows = services.count
            }
        }
        else {
            //TODO number of comments here...
            rows = 0
        }
        
        
        return rows;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if let center = self.center {
//            
//            if self.optionsSegmentedControl.selectedSegmentIndex == 0 {
//                
//                if indexPath.row == 0 {
//                    
//                    let cell = tableview.dequeueReusableCellWithIdentifier("addressCell")
//                }
//            }
//            
//            
//        }
        
        return tableView.dequeueReusableCellWithIdentifier("textCell")!;
    }

}
