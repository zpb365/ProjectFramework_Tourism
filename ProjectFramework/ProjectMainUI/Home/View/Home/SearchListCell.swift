//
//  SearchListCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SearchListCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var List_name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! SearchProductModel
        mainImage.ImageLoad(PostUrl: HttpsUrlImage+model._CoverPhoto)
        List_name.text = model._title
        var title = ""
        switch model._channelsid {
        case 1:
            title="景区"
            break
        case 2:
            title="酒店"
            break
        case 3:
            title="餐厅"
            break
        case 4:
            title="旅行社"
            break
        case 5:
            title="会展"
            break
        case 6:
            title="特产"
            break
        case 9:
            title="资讯"
            break
        case 11:
            title="导游"
            break
        default:
            break
        }
        type.text = title
    }
}
