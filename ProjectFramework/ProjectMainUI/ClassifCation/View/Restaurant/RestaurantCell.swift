//
//  RestaurantCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var BaseView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BaseView.layer.borderColor = UIColor().TransferStringToColor("#BBBBBB").cgColor
        BaseView.layer.borderWidth = 1.0
        BaseView.layer.shadowColor = UIColor.gray.cgColor
        BaseView.layer.shadowOpacity = 0.5
        BaseView.layer.shadowRadius = 3
        BaseView.layer.shadowOffset  = CGSize(width: CGFloat(1), height: CGFloat(1))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
