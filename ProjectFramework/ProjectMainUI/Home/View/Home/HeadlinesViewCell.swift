//
//  HeadlinesViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HeadlinesViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var CreateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! ClassNewsList_Item
        Title.text=model.Title
        CreateTime.text=model.CreateTime
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
