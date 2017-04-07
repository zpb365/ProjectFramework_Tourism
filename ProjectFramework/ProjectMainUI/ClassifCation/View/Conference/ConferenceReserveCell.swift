//
//  ConferenceReserveCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceReserveCell: UITableViewCell {
    lazy var line: UILabel = {
        let line = UILabel.init()
        line.backgroundColor = UIColor.darkGray
        return line
    }()
    @IBOutlet weak var disPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.line.frame = CommonFunction.CGRect_fram(disPrice.frame.origin.x - 2, y: disPrice.center.y, w: 30, h: 1)
        self.contentView.addSubview(self.line)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
