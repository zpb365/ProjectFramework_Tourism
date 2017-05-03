//
//  BeautyPhotoCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/14.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class BeautyPhotoCell: UITableViewCell {

    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 5
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! ClassBeautifulPictureList_Item
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.PhotoUrl)
        titleLable.text = model.PhotoDescribe
        dateLable.text = model.CreateTime
    }
}
