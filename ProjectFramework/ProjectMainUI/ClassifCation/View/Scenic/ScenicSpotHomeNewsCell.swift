//
//  ScenicSpotHomeNewsCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit



class ScenicSpotHomeNewsCell: UITableViewCell {

    @IBOutlet weak var textLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let modle = cell as! ScenicNewsList_Item
        textLable.text = modle.Title
    }
    
}
