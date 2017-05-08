//
//  TravelGuideViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelGuideViewCell: UITableViewCell {
    
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    weak var delegate:UIViewController?=nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func InitConfig(_ cell: Any) {
        let model =  cell as! TravelsModel
        
        Img.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        Title.text=model.TravelsTitle
        dateTime.text=model.UpdateTime
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
