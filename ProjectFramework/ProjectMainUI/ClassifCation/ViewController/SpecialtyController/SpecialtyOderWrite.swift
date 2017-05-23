//
//  SpecialtyOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyOderWrite: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var product_Name: UILabel!
    @IBOutlet weak var product_Count: UILabel!
    @IBOutlet weak var xuzhi: UIButton!
    @IBOutlet weak var payforBtn: UIButton!
    @IBOutlet weak var payforPrice: UILabel!
    @IBOutlet weak var tableViewFoot: UIView!
    @IBOutlet weak var swichView: UISwitch!
    
    let identiFier = "SpecialtyOderWriteCell"
    var spePoduct: SpecialitiesProduct_List?=nil
    var count = 1
    let textArray = ["收货地址","联系人","联系电话","备注"]
    let placeholderArray = ["请填写真实地址(如若自取可不填)","请填写真实姓名","请填写联系电话","请输入备注"]
    var isOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单填写"
        self.initUI()
    }
    override func viewDidLayoutSubviews() {
        product_Name.text = spePoduct?.Title
        product_Count.text = "\(count)"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        tableViewHead.addGestureRecognizer(tap)
        payforPrice.text = "¥\(spePoduct!.DefaultPrice * count)"
        
        xuzhi.tag = 100
        payforBtn.tag = 101
        swichView.isOn = false
        xuzhi.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        swichView.addTarget(self, action: #selector(swichAtion), for: .valueChanged)
        tableViewFoot.layer.borderWidth = 0.5
        tableViewFoot.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    func swichAtion() -> Void {
        //收获地址
        let index0 = IndexPath.init(row: 0, section: 0)
        let cell0  = tableView.cellForRow(at: index0) as! HotelOderWriteCell
        if swichView.isOn == true {
            
            cell0.textField.isUserInteractionEnabled = false
            print("打开")
        }else{
            cell0.textField.isUserInteractionEnabled = true
            print("关闭")
        }
        isOpen = swichView.isOn
    }
    func tapClick() -> Void {
        
        var title = Array<String>()
        for i in 0..<10 {
            title.append((i+1).description)
        }
        CommonFunction.ActionSheet(ShowTitle: title,sheetWithTitle:"请选择购买的数量" ,ItemsTextColor: UIColor().TransferStringToColor("#52B0E9"), ReturnSelectedIndex: { (index, str) in
            self.count = index + 1
            self.product_Count.text = "\(self.count)"
            self.payforPrice.text = "¥\(self.spePoduct!.DefaultPrice * self.count)"
        })
    }
    func initUI() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 50)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableViewHead.layer.borderWidth = 0.6
        self.tableViewHead.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.tableFooterView = tableViewFoot
        
//        self.swichView.frame = CGRect.init(x: 15, y: 12, width: 50, height: 27)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! SpecialtyOderWriteCell
        cell.keyLable.text = textArray[indexPath.row]
        cell.textField.placeholder = placeholderArray[indexPath.row]
        if indexPath.row == 2 {
            cell.textField.keyboardType = .numberPad
        }
        return cell
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
            //收获地址
            let index0 = IndexPath.init(row: 0, section: 0)
            let cell0 = tableView.cellForRow(at: index0) as! HotelOderWriteCell
            //真实姓名
            let index1 = IndexPath.init(row: 1, section: 0)
            let cell1 = tableView.cellForRow(at: index1) as! HotelOderWriteCell
            //电话
            let index2 = IndexPath.init(row: 2, section: 0)
            let cell2 = tableView.cellForRow(at: index2) as! HotelOderWriteCell
            //备注
            let index3 = IndexPath.init(row: 3, section: 0)
            let cell3 = tableView.cellForRow(at: index3) as! HotelOderWriteCell
//            var isPost = 0
            //不是自取
            if isOpen == false {
                if cell0.textField.text == "" {
                    CommonFunction.HUD("请输入收货地址", type: .error)
                    return
                }
                
            }
            //是自取
            if cell1.textField.text == "" {
                CommonFunction.HUD("请输入真实姓名", type: .error)
                return
            }
            canPayfor = Validate.phoneNum(cell2.textField.text!).isRight
            if canPayfor == true {
                var isPost = 0//0邮寄 1自取
                if isOpen == true {
                    isPost = 1
                }else{
                    isPost = 0
                }
                let parameters = ["RecAddress":(cell0.textField.text)!,"ChannelsListID":spePoduct!.SpecialitiesID,"UserID":Global_UserInfo.userid,"ChannelsListProductID":spePoduct!.SpecialitiesProductID,"Number":count,"TouristName":(cell1.textField.text)!,"TouristPhone":(cell2.textField.text)!,"Remark":(cell3.textField.text)!,"IsPost":isPost] as [String : Any]
                
                let vc =   PayClass(parameters: parameters,Channels: 6,delegate:self)
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

}
