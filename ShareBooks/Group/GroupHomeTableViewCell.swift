//
//  GroupHomeTableViewCell.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class GroupHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    var group: Group! {
        didSet {
            name.text = group.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
