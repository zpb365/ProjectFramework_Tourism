//
//  ScenicSpotCollectionCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotCollectionCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func setData(_ image:String , isHiden:Bool , centerText:String) -> Void {
        icon.isHidden = isHiden
        lable.isHidden = isHiden
        icon.image = UIImage.init(named: image)
        lable.text = centerText
    }

}
