//
//  MyCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    
    typealias CallbackValue=(_ value:UIButton)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
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
        while self.contentView.subviews.last != nil {   //去除重复
            self.contentView.subviews.last?.removeFromSuperview()
        }
        let lineView=UIView(frame: CGRect.init(x: 0, y: 8, width: self.contentView.frame.width, height: 8))
        lineView.backgroundColor=CommonFunction.LineColor()
        self.contentView.addSubview(lineView)
        

        
        let  _width = (CommonFunction.kScreenWidth - 1) / 4
        let _heigth:CGFloat=80
        
        for i in  0..<TitleList.count{
            //一行中的第几个
            let row  = i % 4
            //
            let low = i / 4
            
            let X = (_width + 0.33) * CGFloat(row)
            let Y = (_heigth + 0.33) * CGFloat(low) + lineView.frame.maxY+5
            let btn  = UIButton(frame: CGRect(x: X, y: Y, width: _width, height: _heigth ))
            btn.setTitleColor(UIColor.black, for: UIControlState())
            btn.layer.borderColor=CommonFunction.LineColor().cgColor
            btn.layer.borderWidth=0.3
            btn.tag = 100 + i
            btn.titleLabel?.font=UIFont.systemFont(ofSize: 10)
            btn.setImageTitle(image: UIImage(named: ImageList[i]), title: TitleList[i], titlePosition: .bottom,
                              additionalSpacing: 0, state: .normal)
          
            btn.addTarget(self, action:#selector(buttonClick(button:)), for: .touchUpInside)
            self.contentView.addSubview(btn)
        }
    }
    
    //MARK: buttonClik
    func buttonClick(button:UIButton) -> Void {
        if (myCallbackValue != nil) {
            myCallbackValue!(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
