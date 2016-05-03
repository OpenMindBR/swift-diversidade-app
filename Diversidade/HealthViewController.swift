//
//  HealthViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HealthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var loadingPostsIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    var datasource:[Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datasource = []
    
        self.configureSideMenu(self.menuItem)
        self.retrieveHealthPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
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
            cell.postTextLabel.text = content.text
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 143.0
    }
    
    func retrieveHealthPosts() {
        let requestString = UrlFormatter.urlForNewsFromCategory(Category.Health)
        
        Alamofire.request(.GET, requestString).validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json: Array<JSON> = JSON(value).arrayValue
                    
                    let posts: [Post] = json.map({ (post) -> Post in
                        let text = post["text"].stringValue
                        let title = post["title"].stringValue
                        
                        
                        return Post(title: title, date: "", text: text)
                    })
                    
                    self.datasource = posts
                    self.loadingPostsIndicator.stopAnimating()
                    self.postsTableView.reloadData()
                }
                
            case .Failure:
                print (response.result.error)
            }
        }
    }

}
