//
//  HotelRoomReserveCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelRoomReserveCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var describeLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var disCountPrice: UILabel!
    //用户昵称
    lazy var line: UILabel = {
        let line = UILabel.init()
        line.backgroundColor = UIColor.darkGray
        return line
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.line.frame = CommonFunction.CGRect_fram(disCountPrice.frame.origin.x - 2, y: disCountPrice.center.y, w: 30, h: 1)
        self.contentView.addSubview(self.line)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
