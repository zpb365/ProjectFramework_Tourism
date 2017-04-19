//
//  DateCollectionReusableView.swift
//  日期控件
//
//  Created by 住朋购友 on 2017/3/31.
//  Copyright © 2017年 LYF. All rights reserved.
//

import UIKit

class DateCollectionReusableView: UICollectionReusableView {
    
    var lable : UILabel = {
        let lable = UILabel()
        lable.frame = CGRect.init(x: (CommonFunction.kScreenWidth - 100)/2, y: 5, width: 100, height: 20)
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.textAlignment = .center
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        self.addSubview(lable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
