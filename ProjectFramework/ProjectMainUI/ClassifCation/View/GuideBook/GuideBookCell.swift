//
//  GuideBookCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GuideBookCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var GuideName: UILabel!
    @IBOutlet weak var sexy: UIImageView!
    @IBOutlet weak var ServiceArea: UILabel!
    @IBOutlet weak var WorkingYears: UILabel!
    
    override func awakeFromNib() {
        
    }
    override func InitConfig(_ cell: Any) {
        let model           = cell as! GuideModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        GuideName.text      = model.CiceroneName
        ServiceArea.text    = model.ServiceArea
        WorkingYears.text   = model.WorkingYears
        if model.Sex == 0 {
            sexy.image = UIImage.init(named: "sexy_man")
        }else{
            sexy.image = UIImage.init(named: "sexy_women")
        }
    }
}
