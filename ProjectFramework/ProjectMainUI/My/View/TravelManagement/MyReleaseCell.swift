//
//  MyReleaseCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyReleaseCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var TravelsNote: UILabel!
    
    @IBOutlet weak var datetime: UILabel!
    
    @IBOutlet weak var Views: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! TravelsModel
        Title.text=model.TravelsTitle
        Img.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        TravelsNote.text=model.TravelsNote
        datetime.text=model.UpdateTime
        Views.text=model.Views.description
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
