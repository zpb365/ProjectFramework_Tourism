//
//  RestaurantOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantOderWrite: UIViewController {

    @IBOutlet weak var RestauranProductTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var netxView: UIView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payforPrice: UILabel!
    @IBOutlet weak var xuzhi: UIButton!
    @IBOutlet weak var paforBtn: UIButton!
    
    var ResturantProduct: RestaurantProduct_List!
    var count=1
    let textArray = ["预定人","手机号","备注"]
    let placeholderArray = ["请填写真实姓名","请填写真实号码","请输入备注"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单填写"
        self.initUI()
        self.setData()
    }
    override func viewDidLayoutSubviews() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        netxView.addGestureRecognizer(tap)
        
        xuzhi.tag = 100
        paforBtn.tag = 101
        
        xuzhi.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        paforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    func tapClick() -> Void {
        var title = Array<String>()
        for i in 0..<10 {
            title.append((i+1).description)
        }
        CommonFunction.ActionSheet(ShowTitle: title,sheetWithTitle:"请选择预定的人数" ,ItemsTextColor: UIColor().TransferStringToColor("#52B0E9"), ReturnSelectedIndex: { (index, str) in
            self.count = index + 1
            self.setData()
        })

    }
    //MARK: 按钮方法
    func buttonClick(_ button:UIButton) -> Void {
        switch button.tag {
        case 100:
            let Instructionsview = PulickPayforInstructions.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight))
            Instructionsview.setText(text: "本平台只是提供产品展示，不参与运营过程，一旦出现费用纠纷将由消费者承担，本平台 不承担任何后果。")
            UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(Instructionsview)
            break
        case 101:
            
            break
        default :
            break
        }
    }
    func setData() -> Void {
        RestauranProductTitle.text = ResturantProduct.Title
        price.text = "¥"+" \(ResturantProduct.DefaultPrice)"
        productCount.text = "\(count)"
        totalPrice.text = "¥"+" \(count*ResturantProduct.DefaultPrice)"
        payforPrice.text = "¥"+" \(count*ResturantProduct.DefaultPrice)"
    }
    func initUI() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight  - 50)
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.tableFooterView = UIView.init()
    }
    

}
