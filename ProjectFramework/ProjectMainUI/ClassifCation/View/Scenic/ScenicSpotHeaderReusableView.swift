//
//  ScenicSpotHeaderReusableView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotHeaderReusableView: UICollectionReusableView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setHeader(text: String, color:UIColor , isCreate:Bool) -> Void {
        if isCreate == false {
            let view = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: color, title: text, titleColor: UIColor.black)
            self.addSubview(view)
        }
    }
}
