//
//  PostTableViewCell.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 03/03/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTextLabel: KILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.postTextLabel.urlLinkTapHandler = {
            (label, urlString, range) in
            
            if let url = NSURL(string: urlString){
                UIApplication.sharedApplication().openURL(url)
            }
            
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
