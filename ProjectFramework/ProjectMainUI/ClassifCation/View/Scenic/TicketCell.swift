//
//  TicketCell.swift
//  ProjectFramework
//
//  Created by 住朋购友 on 2017/3/14.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buyButton.layer.borderWidth = 0.5
        buyButton.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
