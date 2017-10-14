//
//  WeightTableViewCell.swift
//  Массовый дневник Swift
//
//  Created by Admin on 28.09.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import UIKit

class WeightTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
