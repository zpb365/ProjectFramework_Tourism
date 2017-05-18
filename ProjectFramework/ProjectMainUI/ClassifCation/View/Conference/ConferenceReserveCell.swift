//
//  ConferenceReserveCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceReserveCell: UITableViewCell {
    typealias CallbackValue=(_ items: Any...)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var tab: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBAction func payForClick(_ sender: Any) {
        if myCallbackValue != nil{
            myCallbackValue!("","","")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! MeetingProduct_List
        mainImage.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleName.text = model.Title
        tab.text = "\(model.Acreage) | \(model.Capacity) | \(model.AdditionalServices)"
        price.text = "¥ \(model.Price)"
    }
}
