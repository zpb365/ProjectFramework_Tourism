//
//  MyOderCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderCell: UITableViewCell {

    typealias CallbackValue=()->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    @IBOutlet weak var stateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        stateButton.layer.borderWidth = 0.5
        stateButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        stateButton.clipsToBounds = true
        stateButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    //MARK: buttonClick
    func buttonClick() -> Void {
        if (myCallbackValue != nil) {
            myCallbackValue!()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
    }
}
