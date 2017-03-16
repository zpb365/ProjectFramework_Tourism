//
//  ScenicIntroduceCell.swift
//  ProjectFramework
//
//  Created by 住朋购友 on 2017/3/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


class ScenicIntroduceCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func InitConfig(_ cell: Any) {
//        
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
