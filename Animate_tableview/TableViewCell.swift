//
//  TableViewCell.swift
//  Animate_tableview
//
//  Created by jayaraj on 10/05/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var btnImage: UIButton?
    @IBOutlet var btnAction: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
