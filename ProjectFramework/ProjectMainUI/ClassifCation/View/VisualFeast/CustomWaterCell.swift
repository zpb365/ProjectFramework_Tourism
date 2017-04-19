//
//  CustomWaterCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class CustomWaterCell: UICollectionViewCell {

    
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.white
        baseView.layer.borderWidth = 0.5
        baseView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        return baseView
    }()
    //主要图片
    lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
//        mainImageView.ImageLoad(PostUrl: "http://seopic.699pic.com/photo/00021/6438.jpg_wh1200.jpg")
        return mainImageView
    }()
    //时间
    lazy var dateLable: UILabel = {
        let dateLable = UILabel()
        dateLable.font = UIFont.systemFont(ofSize: 12)
        dateLable.text = "2017-03-25"
        dateLable.textColor = UIColor.black
        return dateLable
    }()
    //浏览量
    lazy var browseLable: UILabel = {
        let browseLable = UILabel()
        browseLable.font = UIFont.systemFont(ofSize: 12)
        browseLable.text = "2222"
        browseLable.textAlignment = .center
        browseLable.textColor = UIColor.black
        return browseLable
    }()
    //主要图片
    lazy var browseIcon: UIImageView = {
        let browseIcon = UIImageView()
        browseIcon.image = UIImage.init(named: "browse")
        return browseIcon
    }()
    //浏览量
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.font = UIFont.systemFont(ofSize: 12)
        titleLable.text = "我是测试标题"
        titleLable.textColor = UIColor.black
        return titleLable
    }()
    //中间图片
    lazy var centerIcon: UIImageView = {
        let centerIcon = UIImageView()
//        centerIcon.isHidden = true
//        centerIcon.image = UIImage.init(named: "360Panorama")
        return centerIcon
    }()
    //中间lable
    lazy var centerLable: UILabel = {
        let centerLable = UILabel()
        centerLable.font = UIFont.systemFont(ofSize: 15)
//        centerLable.isHidden = true
//        centerLable.text = " 360°"
        centerLable.textAlignment = .center
        centerLable.textColor = UIColor.white
        return centerLable
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.contentView.addSubview(self.baseView)
        self.contentView.addSubview(self.dateLable)
        self.contentView.addSubview(self.browseLable)
        self.contentView.addSubview(self.browseIcon)
        self.contentView.addSubview(self.mainImageView)
        self.contentView.addSubview(self.titleLable)
        self.mainImageView.addSubview(self.centerIcon)
        self.mainImageView.addSubview(self.centerLable)
        self.addConstraint()
    }
    //MARK: 添加约束
    func addConstraint() -> Void {
        self.baseView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        self.dateLable.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.left.equalTo(5)
            make.height.equalTo(20)
            make.bottom.equalTo(0)
        }
        self.browseLable.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.right.equalTo(-5)
            make.height.equalTo(20)
            make.bottom.equalTo(0)
        }
        self.browseIcon.snp.makeConstraints { (make) in
            make.width.equalTo(20)
            make.height.equalTo(15)
            make.bottom.equalTo(-3)
            make.right.equalTo(browseLable.snp.left).offset(0)
        }
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(20)
            make.bottom.equalTo(dateLable.snp.top).offset(0)
        }
        self.mainImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(titleLable.snp.top).offset(-5)
        }
        self.centerIcon.snp.makeConstraints { (make) in
            let marginX = (self.frame.width - 25)/2
            let marginY = (self.frame.height - 50)/2 - 22
            make.width.equalTo(25)
            make.height.equalTo(22)
            make.left.equalTo(mainImageView.snp.left).offset(marginX)
            make.top.equalTo(mainImageView.snp.top).offset(marginY)
        }
        self.centerLable.snp.makeConstraints { (make) in
            let marginX = (self.frame.width - 100)/2
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.top.equalTo(centerIcon.snp.bottom).offset(-3)
            make.left.equalTo(mainImageView.snp.left).offset(marginX)
        }

        
    }
    func setData(_ image:String , isHiden:Bool , centerText:String) -> Void {
        centerIcon.isHidden = isHiden
        centerLable.isHidden = isHiden
        centerIcon.image = UIImage.init(named: image)
        centerLable.text = centerText
    }
}
