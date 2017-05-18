//
//  PulickPayforInstructions.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PulickPayforInstructions: UIView {
    
    lazy var lable: UILabel = {
        let lable = UILabel()
        lable.text = "购买须知"
        lable.font = UIFont.systemFont(ofSize: 12)
        return lable
    }()
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor().TransferStringToColor("#F0F0F2")
        textView.text = ""
        return textView
    }()
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton.init(type: .custom)
        deleteBtn.tag = 102
        deleteBtn.setImage(UIImage.init(named: "delete"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return deleteBtn
    }()

    //MARK: buttonClick
    func buttonClick(button: UIButton) -> Void {
        self.removeFromSuperview()
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(lable)
        self.addSubview(textView)
        self.addSubview(deleteBtn)
        
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(10)//宽高相等
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(80)//底部相对父控件的约束条件
            make.height.equalTo(20)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(40)//底部相对父控件的约束条件
            make.height.equalTo(30)
            make.right.equalTo(0)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(40)//右边相对父控件的约束条件r
            make.left.equalTo(0)//底部相对父控件的约束条件
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setText(text:String) -> Void {
        textView.text = text
    }
}
