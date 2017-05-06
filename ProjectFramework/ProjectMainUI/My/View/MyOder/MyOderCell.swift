//
//  MyOderCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit



class MyOderCell: UITableViewCell {

    typealias CallbackValue=(_ OrderType:Int)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var stateButton: UIButton!
    
    @IBOutlet weak var OrderType: UILabel!
    
    @IBOutlet weak var PayType: UILabel!
    
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var PayMoney: UILabel!
    
    @IBOutlet weak var OrderDescribe: UILabel!
    
    @IBOutlet weak var Describe: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! MyOrderModel
     OrderType.text=model.OrderTypeName
        PayType.text=model.OrderStatus
        Img.ImageLoad(PostUrl: HttpsUrlImage+model.Pic)
        Title.text=model.Title
        PayMoney.text="￥"+model.OrderAmount.description
        OrderDescribe.text=model.TitleProduct
        Describe.text=model.Describe
        logo.ImageLoad(PostUrl: HttpsUrlImage+model.Logo)
        
        stateButton.layer.borderWidth = 0.5
        stateButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        stateButton.clipsToBounds = true
        stateButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        stateButton.isHidden=true
        if(model.IsPay=="1"&&model.Isevaluate=="0"){    //是否待付款
          stateButton.setTitle("待付款", for: .normal)
            stateButton.isHidden=false
            stateButton.tag=0   //0 代表付款
        }
        if(model.IsPay=="0"&&model.Isevaluate=="1"){    //是否待付款
            stateButton.setTitle("待评价", for: .normal)
            stateButton.isHidden=false
            stateButton.tag=1   //1 代表评价
        }
        
        
        
    }
    //MARK: buttonClick
    func buttonClick() -> Void {
        
        if (myCallbackValue != nil) {
            myCallbackValue!(stateButton.tag)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
    }
}
