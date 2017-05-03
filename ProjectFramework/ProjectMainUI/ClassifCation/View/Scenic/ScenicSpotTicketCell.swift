//
//  ScenicSpotTicketCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/19.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotTicketCell: UITableViewCell {

    typealias CallbackValue=(_ value:String)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    @IBAction func Payforticket(_ sender: Any) {
        if myCallbackValue != nil{
            myCallbackValue!("")
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
//    var item:ScenicTicketList?=nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! ScenicTicketList
        titleLable.text = model.Title
        if model.TicketsTypes == 0 {
            typeLable.text = "门票类型：电子票"
        }
        priceLable.text = "¥\(model.DefaultPrice)"
    }
}
