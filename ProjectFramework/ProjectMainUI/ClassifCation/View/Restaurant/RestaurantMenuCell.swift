//
//  RestaurantMenuCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantMenuCell: UITableViewCell {

    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    @IBOutlet weak var menuCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        
//        menuName.layer.addSublayer(border)
//        menuPrice.layer.addSublayer(border)
//        menuCount.layer.addSublayer(border)
        self.setLayer(lable: menuName)
        self.setLayer(lable: menuPrice)
        self.setLayer(lable: menuCount)
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! Menu_List
        menuName.text = model.Name
        menuPrice.text = "¥\(model.Price)"
        menuCount.text = model.Specifications+"份"
    }
    func setLayer(lable:UILabel) -> Void {
        let border = CAShapeLayer.init()
        border.strokeColor = UIColor.gray.cgColor
        border.fillColor = UIColor.clear.cgColor
        border.path = UIBezierPath(rect: menuName.bounds).cgPath
        border.frame = menuName.bounds
        border.lineCap = "1"
        border.lineDashPattern = [2, 4]
        lable.layer.addSublayer(border)
    }
}
