//
//  ScenicSiftView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/6/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


class ScenicSiftView: UIView {
    
    
    typealias CallbackValue=(_ value:String)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    var array = Array<Any>()
    let rowCount = 4 //行数
    let View_K = 70  //控件宽度
    let View_H = 25  //控件高度
    let magin = 10  //x起始距离
    var currenButton: UIButton? = nil
    lazy var baseView: UIView = {
        let baseView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 100))
        baseView.backgroundColor = UIColor.white
        return baseView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.addSubview(self.baseView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func tapClick() -> Void {
        self.isHidden = true
    }
    func initUI(_ tabModelArray: Array<Any>) -> Void {
        
        let model = TabModel()
        model.tabName = "全部"
        model.channelID = 0
        model.tabClassID = 0
        self.array = tabModelArray
        self.array.insert(model, at: 0)
        
        let xMarginSum = CommonFunction.kScreenWidth - CGFloat(rowCount) * CGFloat(View_K) - CGFloat(2 * magin)
        let xMargin = xMarginSum / CGFloat(rowCount - 1)
        let yMargin = 10
               //
        for i in 0..<self.array.count {
            //一行中的第几个
            let row  = i % rowCount
            //第几行
            let low = i / rowCount
            let X = (CGFloat(View_K) + xMargin) * CGFloat(row) + CGFloat(magin)
            let Y = CGFloat(View_H + yMargin) * CGFloat(low) + 10
            let item = self.array[i] as! TabModel
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: X, y: Y, width: CGFloat(View_K), height: CGFloat(View_H))
            button.layer.cornerRadius = 4
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            button.setTitle(item.tabName, for: .normal)
            button.tag = i
            if i == 0 {
                button.backgroundColor = UIColor().TransferStringToColor("#00ABEE")
                button.setTitleColor(UIColor.white, for: .normal)
                currenButton = button
            }else{
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor().TransferStringToColor("#00ABEE"), for: .normal)
            }
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    func buttonClick(button:UIButton) -> Void {
        //反选
        currenButton?.backgroundColor = UIColor.white
        currenButton?.setTitleColor(UIColor().TransferStringToColor("#00ABEE"), for: .normal)
        button.backgroundColor = UIColor().TransferStringToColor("#00ABEE")
        button.setTitleColor(UIColor.white, for: .normal)
        currenButton = button
        
        self.isHidden = true
        if myCallbackValue != nil {
            let model = self.array[button.tag] as! TabModel
            if button.tag == 0 {
                myCallbackValue!("")
            }else{
                myCallbackValue!(model.tabName)
            }
            
        }
    }
}
