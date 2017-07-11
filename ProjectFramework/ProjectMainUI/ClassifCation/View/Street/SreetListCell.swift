//
//  SreetListCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SreetListCell: UITableViewCell {

    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var adresslabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! StreetModel
        iamgeView.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
        titleLable.text = model.StreetName
        adresslabel.text = model.Address
    }
}
