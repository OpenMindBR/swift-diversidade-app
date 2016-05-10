//
//  AboutViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var datasource: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datasource = self.readDevelopersPlist()
        self.configureSideMenu(self.menuItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let datasource = self.datasource,
            let developer = datasource[indexPath.row] as? NSDictionary,
            let fbProfileLink  = developer["facebookLink"] as? String {
                
                self.openSafariAt(fbProfileLink)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("about_cell")
        
        if let datasource = self.datasource,
            let developer = datasource[indexPath.row] as? NSDictionary {
                cell?.textLabel?.text = developer["name"] as? String
        }
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        if let datasource = self.datasource {
            rows = datasource.count
        }
        
        return rows
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Desenvolvedores"
    }
    func readDevelopersPlist() -> NSArray?{
        let path = NSBundle.mainBundle().pathForResource("Developers", ofType: ".plist")
        
        return NSArray(contentsOfFile: path!)
    }
    
    func openSafariAt(link:String){
        let url = NSURL(string: link)
        UIApplication.sharedApplication().openURL(url!)
    }

}
