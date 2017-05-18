//
//  TimeQuantum.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/29.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TimeQuantum: UIView {
    typealias CallbackValue=(_ value:UIButton)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeBtn: UIButton!

    
    override func layoutSubviews() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        dateButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        timeBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    func setData(moon:Int , day:Int , timeStr:String) -> Void {
        dateButton.setTitle("\(moon)月\(day)日", for: .normal)
        timeBtn.setTitle(timeStr, for: .normal)
    }
    func buttonClick(button:UIButton) -> Void {
        if myCallbackValue != nil {
            myCallbackValue!(button)
        }
    }
}
