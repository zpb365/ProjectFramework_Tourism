//
//  PulickIntroduceCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PulickIntroduceCell: UITableViewCell {
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel.init(frame: CommonFunction.CGRect_fram(self.line.frame.maxX + 5, y: 5, w: 100, h:15 ))
        titleLable.text = "我是标题"
        titleLable.textColor = UIColor.darkGray
        titleLable.font = UIFont.systemFont(ofSize: 13)
        return titleLable
    }()

    lazy var line: UILabel = {
        let line = UILabel.init(frame: CommonFunction.CGRect_fram(9, y: 5, w: 2, h:13 ))
        line.backgroundColor = UIColor().TransferStringToColor("#26C6DA")
        return line
    }()

    lazy var describe: UILabel = {
        let describe = UILabel.init(frame: CommonFunction.CGRect_fram(5, y: 3, w: CommonFunction.kScreenWidth - 30, h:0 ))
        describe.font = UIFont.systemFont(ofSize: 13)
        describe.numberOfLines = 0
        return describe
    }()
    lazy var baeseView: UIView = {
        let baeseView = UIView.init(frame: CommonFunction.CGRect_fram(10, y: self.titleLable.frame.maxY + 5, w: CommonFunction.kScreenWidth - 20, h:10 ))
        baeseView.backgroundColor = UIColor().TransferStringToColor("#EBEBEB")
        baeseView.layer.cornerRadius = 4
        return baeseView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.line)
        self.contentView.addSubview(self.titleLable)
        self.contentView.addSubview(self.baeseView)
        self.baeseView.addSubview(self.describe)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func InitConfig(_ cell: Any) {
        let model  = cell as! DescribeName_ListItem
        let height = model.Describel.ContentSize(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize(width: CommonFunction.kScreenWidth - 30, height: 0)).height
        self.baeseView.frame = CommonFunction.CGRect_fram(10, y: self.titleLable.frame.maxY + 5, w: CommonFunction.kScreenWidth - 20, h:height + 5 )
        self.describe.frame = CommonFunction.CGRect_fram(5, y: 3, w: CommonFunction.kScreenWidth - 30, h:height )
        self.describe.text = model.Describel
        self.titleLable.text = model.Title
    }
    
}
