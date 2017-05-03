//
//  SpecialtyCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! SpecialitiesModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.SpecialitiesName
    }
}
