//
//  RestaurantOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantOderWrite: UIViewController,UITableViewDelegate,UITableViewDataSource {

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
    
    let identiFier = "ResturantOderWriteCell"
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
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 101:
            if(Global_UserInfo.IsLogin==false){
                let vc = LoginViewControllerTwo()
                self.present(vc, animated: true, completion: nil)
                return
            }
            var canPayfor: Bool = false
            //预定人
            let index0 = IndexPath.init(row: 0, section: 0)
            let cell0 = tableView.cellForRow(at: index0) as! HotelOderWriteCell
            //电话号码
            let index1 = IndexPath.init(row: 1, section: 0)
            let cell1 = tableView.cellForRow(at: index1) as! HotelOderWriteCell
            //备注
            let index2 = IndexPath.init(row: 2, section: 0)
            let cell2 = tableView.cellForRow(at: index2) as! HotelOderWriteCell
            
            if cell0.textField.text == "" {
                CommonFunction.HUD("请输入真实姓名", type: .error)
                return
            }
            canPayfor = Validate.phoneNum(cell1.textField.text!).isRight
            if canPayfor == true {
                let parameters = ["ChannelsListProductID":ResturantProduct.RestaurantProductID,"ChannelsListID":ResturantProduct.RestaurantID,"UserID":Global_UserInfo.userid,"Number":count,"TouristName":(cell0.textField.text)!,"TouristPhone":(cell1.textField.text)!,"Remark":(cell2.textField.text)!] as [String : Any]
                
                let vc =   PayClass(parameters: parameters,Channels: 3,delegate:self)
                self.present(vc, animated: false, completion: nil)
                print("提交订单")
            }else{
                CommonFunction.HUD("请输入正确的手机号码", type: .error)
            }
            
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.tableFooterView = UIView.init()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ResturantOderWriteCell
        cell.keyLable.text = textArray[indexPath.row]
        cell.titexField.placeholder = placeholderArray[indexPath.row]
        if indexPath.row == 1 {
            cell.titexField.keyboardType = .numberPad
        }
        return cell
    }
    
}
