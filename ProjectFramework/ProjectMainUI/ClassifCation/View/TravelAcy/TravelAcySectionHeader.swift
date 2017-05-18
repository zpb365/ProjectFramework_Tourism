//
//  TravelAcySectionHeader.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcySectionHeader: UIView {

    typealias CallbackValue=(_ value:String)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    
    override func layoutSubviews() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(tap)
    }
    func tapClick() -> Void {
        if myCallbackValue != nil {
            myCallbackValue!("")
        }
    }
    func setData(object:Any) -> Void {
        let model = object as! TravelAgencyModel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        titleLable.text = model.TravelAgencyName
        let score = model.Score / 5 * 100
        scoreLable.text = "\(score)%满意"
    }
    
}
