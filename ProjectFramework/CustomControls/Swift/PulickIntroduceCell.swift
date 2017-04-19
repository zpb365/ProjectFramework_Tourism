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
        titleLable.font = UIFont.systemFont(ofSize: 11)
        return titleLable
    }()

    lazy var line: UILabel = {
        let line = UILabel.init(frame: CommonFunction.CGRect_fram(9, y: 5, w: 2, h:13 ))
        line.backgroundColor = UIColor().TransferStringToColor("#26C6DA")
        return line
    }()

    lazy var describe: UILabel = {
        let describe = UILabel.init(frame: CommonFunction.CGRect_fram(10, y: self.titleLable.frame.maxY + 5, w: CommonFunction.kScreenWidth - 20, h:10 ))
        describe.font = UIFont.systemFont(ofSize: 11)
        describe.backgroundColor = UIColor().TransferStringToColor("#EBEBEB")
        describe.numberOfLines = 0
        return describe
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
        self.contentView.addSubview(self.describe)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func InitConfig(_ cell: Any) {
        let string = cell as! String
        let height = string.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 20, height: 0)).height
        self.describe.frame = CommonFunction.CGRect_fram(10, y: self.titleLable.frame.maxY + 5, w: CommonFunction.kScreenWidth - 20, h:height )
        self.describe.text = string
    }
    
}
