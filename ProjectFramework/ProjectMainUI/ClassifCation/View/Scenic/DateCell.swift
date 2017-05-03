//
//  DateCell.swift
//  日期控件
//
//  Created by 住朋购友 on 2017/3/30.
//  Copyright © 2017年 LYF. All rights reserved.
//

import UIKit


class DateCell: UICollectionViewCell {
    
    lazy var selectorView:UIView = {
        let selectorView = UIView.init(frame: CGRect.init(x: (CommonFunction.kScreenWidth/7 - 20)/2, y: 3, width: 20, height: 20))
        selectorView.backgroundColor = UIColor.red
        selectorView.layer.cornerRadius = 10
        selectorView.clipsToBounds = true
        selectorView.isHidden = true
        return selectorView
    }()
    
    var dateLable = UILabel()
    var priceLable = UILabel()
    var model: ScenicDatePriceList_Item?=nil
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        dateLable.frame = CGRect.init(x: 0, y: 5, width: CommonFunction.kScreenWidth/7, height: 15)
        dateLable.textAlignment = .center
        dateLable.font = UIFont.systemFont(ofSize: 13)
        
        priceLable.frame = CGRect.init(x: 0, y: 25, width: CommonFunction.kScreenWidth/7, height: 15)
        priceLable.textColor = UIColor.lightGray
        priceLable.text = ""
        priceLable.textAlignment = .center
        priceLable.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(self.selectorView)
        self.contentView.addSubview(dateLable)
        self.contentView.addSubview(priceLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setDate(time:Int, isToday:Bool) -> Void {
        if isToday {
            dateLable.text = "今天"
        }
        else{
            dateLable.text = String(time)
        }
//        priceLable.text = "¥17"
    }
    func selectored() -> Void {
        selectorView.isHidden = false
        self.dateLable.textColor = UIColor.white
    }
    func reduction() -> Void {
        selectorView.isHidden = true
        self.dateLable.textColor = UIColor.black
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! ScenicDatePriceList_Item
        self.model = model
        priceLable.text = "¥\(model.Price)"
    }
}
