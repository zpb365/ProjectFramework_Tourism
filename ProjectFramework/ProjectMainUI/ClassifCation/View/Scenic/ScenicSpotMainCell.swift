//
//  ScenicSpotMainCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotMainCell: UITableViewCell {


    
    @IBOutlet weak var mainImageView1: UIImageView!
    @IBOutlet weak var mainImageView2: UIImageView!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ image:String , isHiden:Bool , centerText:String) -> Void {
        icon1.isHidden = isHiden
        icon2.isHidden = isHiden
        lable1.isHidden = isHiden
        lable2.isHidden = isHiden
        icon1.image = UIImage.init(named: image)
        icon2.image = UIImage.init(named: image)
        lable1.text = centerText
        lable2.text = centerText
    }
}
