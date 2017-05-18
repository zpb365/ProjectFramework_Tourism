//
//  ClassifCationCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


class ClassifCationCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var textLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
//    override func layoutSubviews() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.lightGray.cgColor
//    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! ClassifCationModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model._coverphoto)
        textLable.text = model._channelname
    }
    
  
   
}
