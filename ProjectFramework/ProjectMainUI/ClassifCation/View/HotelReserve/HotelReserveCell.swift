//
//  HotelReserveCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelReserveCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var tabLable: UILabel!
    @IBOutlet weak var commentLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! HotelReserveModel
        mainImageView.ImageLoad(PostUrl:HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.HotelName
        commentLable.text = "\(model.CommentsCount)评论数"
        priceLable.text = "¥\(model.lowestPrice)起"
        tabLable.text = model.tab
        let score = model.Score / 5 * 100
        scoreLable.text = "\(score)%满意"
    }
}
