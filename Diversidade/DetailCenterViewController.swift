//
//  DetailCenterViewController.swift
//  
//
//  Created by Francisco José A. C. Souza on 06/04/16.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var centerProfileImage: UIImageView!
    @IBOutlet weak var centerCoverPicture: UIImageView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var centerPhoneLabel: UITextView!
    
    @IBOutlet weak var optionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    var center: Nucleo?
    var centerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCenterDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.centerNameLabel.text = center?.name
        self.centerPhoneLabel.text = center?.phone
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sections = 1
        
        switch optionsSegmentedControl.selectedSegmentIndex {
            case 0:
                sections = 2
            
            default:
                sections = 1
        }
        
        return sections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        switch optionsSegmentedControl.selectedSegmentIndex {
        case 0:
            
            if section == 0 {
                rows = 1
            }
            else {
                if let center = center, let horary = center.horary {
                    rows = horary.count
                }
                else {
                    rows = 0
                }
            }
            
        case 1:
            
            if let center = self.center, let services = center.services {
                rows = services.count
            }
            else {
                rows = 0
            }
            
        case 2:
            if let center = self.center, let comments = center.comments {
                rows = comments.count
            }
            else {
                rows = 0
            }

            
        default:
            rows = 0
        }
        
        return rows;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch optionsSegmentedControl.selectedSegmentIndex {
        case 0:
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("basicCell") as UITableViewCell!
                cell.textLabel?.text = center?.address
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("cellsubdatail") as UITableViewCell!
                
                if let center = self.center, let horaries = center.horary {
                    cell.textLabel?.text = horaries[indexPath.row].day
                    cell.detailTextLabel?.text = horaries[indexPath.row].time
                }
                
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("cellsubdatail") as UITableViewCell!
            
            if let center = self.center, let services = center.services {
                cell.textLabel?.text = services[indexPath.row].title
                cell.detailTextLabel?.text = services[indexPath.row].description
            }
            
            return cell
            
        case 2:
            let cell = tableview.dequeueReusableCellWithIdentifier("cellPost") as! PostTableViewCell
            
            if let center = self.center, let comments = center.comments {
                cell.titleLabel.text    = comments[indexPath.row].name
                cell.postTextLabel.text = comments[indexPath.row].text
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch optionsSegmentedControl.selectedSegmentIndex {
        case 0:
            if section == 0 {
                return "Endereço"
            }
            else {
                return "Horário de Funcionamento"
            }
            
        case 1:
            return "Serviços Prestados"
            
        case 2:
            return "Comentários "
        
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func changeInfoOption(sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 2) {
            retrieveCommentsForCenter()
        }
        else {
            UIView.transitionWithView(tableview,
                                      duration: 0.40,
                                      options: .TransitionCrossDissolve,
                                      animations: {
                                        self.tableview.reloadData()
                                      },
                                      completion: nil)
        }
        
    }
    
    @IBAction func onNewCommentTap(sender: AnyObject) {
        performSegueWithIdentifier("newCommentSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newCommentSegue" {
            let destinationViewController = segue.destinationViewController as! NewCommentViewController
            
            destinationViewController.centerId = self.centerId
        }
    }
    
    func retrieveCenterDetails() {
        
        if let id = self.centerId {
            let requestUrl = UrlFormatter.urlForCenterDetailsWithId(String(id))
            
            Alamofire.request(.GET, requestUrl).validate().responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .Success:
                    
                    if let value = response.result.value {
                        let json = JSON(value).dictionaryValue
                        
                        print(json)
                        
                        let id = json["id"]!.stringValue
                        let name = json["name"]!.stringValue
                        let phone = json["phone"]!.stringValue
                        let address = json["address"]!.stringValue
                        
                        let operating_hours = json["operating_hours"]!.arrayValue
                        let services = json["services"]!.arrayValue
                    
                        
                        let nucleo = Nucleo(id: id, name: name, address: address, phone: phone)
                        
                        nucleo.horary = operating_hours.map({ (operatingHour) -> Horary in
                            let dayOfWeek = operatingHour["day_of_week"].stringValue
                            let hour = operatingHour["hour"].stringValue
                            
                            return Horary(day: dayOfWeek, time: hour)
                        })
                        
                        nucleo.services = services.map({ (service) -> Service in
                            let name = service["name"].stringValue
                            let desc = service["description"].stringValue
                            
                            return Service(title: name, description: desc)
                        })
                        
                        
                        self.centerNameLabel.text  = nucleo.name
                        self.centerPhoneLabel.text = nucleo.phone
                        self.centerPhoneLabel.linkTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
                        
                        self.center = nucleo
                        self.tableview.reloadData()
                    }
                    
                case .Failure:
                    print (response.result.error)
                }
                
            })
        }
    }
    
    func retrieveCommentsForCenter() {
        let requestUrl = UrlFormatter.urlForCommentPost(centerId)
        Alamofire.request(.GET, requestUrl).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value).arrayValue
                    
                    self.center?.comments = json.map({ (commentJson) -> Comment in
                        let name = commentJson["name"].stringValue
                        let text = commentJson["text"].stringValue
                        
                        return Comment(name: name, text: text)
                    })
                    
                    self.tableview.reloadData()
                }
                
            case .Failure:
                print(response.result.error)
            }
            
        })
    }

}
