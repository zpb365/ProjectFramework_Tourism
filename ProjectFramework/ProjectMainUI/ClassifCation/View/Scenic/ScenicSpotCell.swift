//
//  ScenicSpotCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var look: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! ScenicModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.ScenicName
        address.text = "地址："+model.Address
        let num = model.Views + 99
        look.text = "浏览量："+"\(num)"
    }
}
