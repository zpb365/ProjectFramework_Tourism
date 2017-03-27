//
//  DateView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class DateView: UIView {

    let dateLable = UILabel()
    let priceLable = UILabel()
    
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.dateLable.frame = CommonFunction.CGRect_fram(0, y: 0, w: frame.width, h: frame.height / 2)
        self.dateLable.text = "03-08"
        self.dateLable.textAlignment = .center
        self.dateLable.font = UIFont.systemFont(ofSize: 13)
        
        self.priceLable.frame = CommonFunction.CGRect_fram(0, y: frame.height / 2, w: frame.width, h: frame.height / 2)
        self.priceLable.text = "¥1299/人"
        self.priceLable.textAlignment = .center
        self.priceLable.font = UIFont.systemFont(ofSize: 13)
        self.priceLable.textColor = UIColor().TransferStringToColor("#FF5722")
        
        self.addSubview(self.dateLable)
        self.addSubview(self.priceLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
