//
//  TravelAcyProductCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyProductCell: UITableViewCell {
    typealias CallbackValue=(_ value:String)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var groupStaut: UILabel!
    
    @IBAction func payforClick(_ sender: Any) {
        if myCallbackValue != nil{
            myCallbackValue!("")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! TravelAgencyProduct_List
        mainImage.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        detail.text = model.Title
        price.text = "¥ \(model.DefaultPrice)"
        switch model.Nature {
        case 1:
            groupStaut.text = "参团游"
            break
        case 2:
            groupStaut.text = "自由行"
            break
        case 3:
            groupStaut.text = "团队游"
            break
        case 4:
            groupStaut.text = "自驾游"
            break
        default:
            break
        }
    }
}
