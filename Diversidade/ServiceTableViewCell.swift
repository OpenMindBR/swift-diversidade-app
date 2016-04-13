//
//  ServiceTableViewCell.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 08/04/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceTextLabel: UILabel!
    @IBOutlet weak var serviceTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
