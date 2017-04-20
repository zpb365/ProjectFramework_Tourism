//
//  MessageViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var Msg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
         let model = cell as! PushMessageInfoModel
         Msg.text=model._msg
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
