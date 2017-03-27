//
//  RestaurantComboCell.swift
//  
//
//  Created by 住朋购友 on 2017/3/25.
//
//

import UIKit

class RestaurantComboCell: UITableViewCell {
    
    //用户昵称
    lazy var line: UILabel = {
        let line = UILabel.init()
        line.backgroundColor = UIColor.darkGray
        return line
    }()
    @IBOutlet weak var disCountPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.line.frame = CommonFunction.CGRect_fram(disCountPrice.frame.origin.x - 2, y: disCountPrice.center.y, w: 30, h: 1)
        self.contentView.addSubview(self.line)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
