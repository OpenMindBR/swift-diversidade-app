//
//  DiscoveringViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DiscoveringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    var datasource:[Post]?
    
    override func viewDidLoad() {
        let post = Post(category: "Health", title: "Some long long title here", date: "22/22/22", text: "www.google.com")
        datasource = [post]
        
        super.viewDidLoad()
        self.configureSideMenu(self.menuItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 1
        
        if let datasource = self.datasource {
            rows =  datasource.count
        }
        
        return rows
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("post_cell") as! PostTableViewCell
        
        if let datasource = self.datasource {
            let content = datasource[indexPath.row]
            
            cell.titleLabel.text = content.title
            cell.dateLabel.text  = content.date
            cell.postTextLabel.text = content.text
        }
        
        return cell
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
