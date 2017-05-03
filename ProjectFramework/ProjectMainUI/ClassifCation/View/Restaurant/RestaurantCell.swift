//
//  RestaurantCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var describeLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BaseView.layer.borderColor = UIColor().TransferStringToColor("#BBBBBB").cgColor
        BaseView.layer.borderWidth = 1.0
        BaseView.layer.shadowColor = UIColor.gray.cgColor
        BaseView.layer.shadowOpacity = 0.5
        BaseView.layer.shadowRadius = 3
        BaseView.layer.shadowOffset  = CGSize(width: CGFloat(1), height: CGFloat(1))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! RestaurantModel
        mainImageView.ImageLoad(PostUrl:HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.RestaurantName
        priceLable.text = "¥\(model.lowestPrice)起"
        let score = model.Score / 5 * 100
        scoreLable.text = "\(score)%满意"
        describeLable.text = model.tab
    }
}
