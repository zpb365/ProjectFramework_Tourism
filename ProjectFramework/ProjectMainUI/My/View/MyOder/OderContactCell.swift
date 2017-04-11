//
//  OderContactCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class OderContactCell: UITableViewCell {

    @IBOutlet weak var keyLable: UILabel!
    @IBOutlet weak var valueLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(key:String ,value:String) -> Void {
        keyLable.text = key
        valueLable.text = value
    }
}
