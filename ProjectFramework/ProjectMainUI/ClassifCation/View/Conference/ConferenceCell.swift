//
//  ConferenceCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceCell: UICollectionViewCell {
    @IBOutlet weak var scorce: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rommCount: UILabel!
    @IBOutlet weak var persentCount: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        self.layer.borderWidth = 0.5
    }
    
    override func InitConfig(_ cell: Any) {
        let model       = cell as! MeetingModel
        mainImageView.ImageLoad(PostUrl:HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.MeetingName
        distance.text   = "楼层："+model.Storey
        price.text      = "¥\(model.lowestPrice)起"
        rommCount.text  = "会议室：\(model.ConferenceRoom)间"
        persentCount.text   = "容纳人数："+model.CapacityPeople
        let score = model.Score / 5 * 100
        scorce.text = "\(score)%满意"
    }
}
