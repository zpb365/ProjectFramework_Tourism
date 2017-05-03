//
//  TravelAcySectionHeader.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcySectionHeader: UIView {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    func setData(object:Any) -> Void {
        let model = object as! TravelAgencyModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.TravelAgencyName
        let score = model.Score / 5 * 100
        scoreLable.text = "\(score)%满意"
    }

}
