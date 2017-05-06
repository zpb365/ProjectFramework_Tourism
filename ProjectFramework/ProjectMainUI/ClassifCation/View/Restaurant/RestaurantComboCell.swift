//
//  RestaurantComboCell.swift
//  
//
//  Created by 住朋购友 on 2017/3/25.
//
//

import UIKit

class RestaurantComboCell: UITableViewCell {
    
    typealias CallbackValue=(_ value:String)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    //线
    lazy var line: UILabel = {
        let line = UILabel.init()
        line.backgroundColor = UIColor.darkGray
        return line
    }()
    @IBOutlet weak var disCountPrice: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var tab: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBAction func parForClick(_ sender: Any) {
        if myCallbackValue != nil{
            myCallbackValue!("")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.line.frame = CommonFunction.CGRect_fram(disCountPrice.frame.origin.x - 2, y: disCountPrice.center.y, w: 30, h: 1)
        self.contentView.addSubview(self.line)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func InitConfig(_ cell: Any) {
        let model = cell as! RestaurantProduct_List
        titleLable.text = model.Title
        mainImage.ImageLoad(PostUrl: HttpsUrlImage+model.CoverPhoto)
        price.text = "¥\(model.DefaultPrice)"
        disCountPrice.text = "¥\(model.OriginalPrice)"
        tab.text = model.Description+"|"+model.Reservation
    }
}
