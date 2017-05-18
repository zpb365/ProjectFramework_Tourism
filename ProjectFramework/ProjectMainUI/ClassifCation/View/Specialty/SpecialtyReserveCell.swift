//
//  SpecialtyReserveCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/29.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyReserveCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! SpecialitiesProduct_List
        mainImage.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        productName.text = model.Title
        price.text = "¥\(model.DefaultPrice)"
    }
}
