//
//  DiscoveringViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DiscoveringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var loadingPostsIndicator: UIActivityIndicatorView!
    
    var datasource:[Post]?
    
    override func viewDidLoad() {
        datasource = []
        
        super.viewDidLoad()
        self.configureSideMenu(self.menuItem)
        
        self.retrieveDiscoveringPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("discovering_cell", forIndexPath: indexPath) as! PostTableViewCell
        
        if let datasource = self.datasource {
            let content = datasource[indexPath.row]
            
            cell.titleLabel.text = content.title
            cell.postTextLabel.text = content.text
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let datasource = datasource, let sourceUrl = datasource[indexPath.row].url {
            
            if let url = NSURL(string: sourceUrl) {
                UIApplication.sharedApplication().openURL(url)
            }
            
        }
    }
    
    func retrieveDiscoveringPosts() {
        let requestString = UrlFormatter.urlForNewsFromCategory(Category.Discovering)
        
        Alamofire.request(.GET, requestString).validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json: Array<JSON> = JSON(value).arrayValue
                    
                    let posts: [Post] = json.map({ (post) -> Post in
                        let text  = post["text"].stringValue
                        let title = post["title"].stringValue
                        let url   = post["source"].stringValue
                    
                        
                        return Post(title: title, url: url, text: text)
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
