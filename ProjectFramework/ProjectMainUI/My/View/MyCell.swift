//
//  MyCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "MyCell")
    }
    
   
    func _InitConfig(_ ImageList: [String],_ TitleList:[String]) {
        let lineView=UIView(frame: CGRect.init(x: 0, y: 8, width: self.contentView.frame.width, height: 8))
        lineView.backgroundColor=CommonFunction.LineColor()
        self.contentView.addSubview(lineView)
        
        let  _width = (self.contentView.frame.width*(1+1)-self.contentView.frame.width) / CGFloat(4) //整个view宽度的100% / 4
        let _heigth:CGFloat=80
        var ForIndex=0
        for index in  0...TitleList.count/4 {
            for  i:Int in 0  ..< 4 {
                if(ForIndex>=TitleList.count){
                    return
                }
                let btn  = UIButton(frame: CGRect(x: CGFloat(i)*_width, y: (CGFloat(index)*_heigth)+lineView.frame.maxY+5, width: _width, height: _heigth ))
                btn.setTitleColor(UIColor.black, for: UIControlState())
                btn.layer.borderColor=CommonFunction.LineColor().cgColor
                btn.layer.borderWidth=0.3
                btn.titleLabel?.font=UIFont.systemFont(ofSize: 10)
                btn.setImageTitle(image: UIImage(named: ImageList[ForIndex]), title: TitleList[ForIndex], titlePosition: .bottom,
                                  additionalSpacing: 0, state: .normal)
                self.contentView.addSubview(btn)
                ForIndex += 1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}
