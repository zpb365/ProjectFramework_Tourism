//
//  HotelRoomReserveCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelRoomReserveCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var describeLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! HotelProduct_List
        imageIcon.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.Title
        describeLable.text = "\(model.BedType)|\(model.Network)|\(model.Acreage)|\(model.Policy)"
        priceLable.text = "¥\(model.Price)"
    }
}
