//
//  MarketListCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MarketListCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var cootenLable: UILabel!
    @IBOutlet weak var adressLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! MarketModel
        titleLable.text = model.MarketName
        mainImage.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
        cootenLable.text = model.ShortDescription
        adressLable.text = model.Address
    }
}
