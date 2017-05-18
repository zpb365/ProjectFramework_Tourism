//
//  TravelAcyOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyOderWrite: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var product_title: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var pepoleCount: UILabel!
    @IBOutlet weak var xuzhi: UIButton!
    @IBOutlet weak var payforBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    let identiFier = "TravelOderWriteCell"
    @IBAction func back(_ sender: Any) {
        
        CommonFunction.AlertController(self, title: "取消订单", message: "您暂未支付该订单，是否要取消订单？", ok_name: "确定", cancel_name: "取消", OK_Callback: {
            self.navigationController?.popViewController(animated: true)
        }, Cancel_Callback: {
            
        })
    }
    
    var model: ScenicDatePriceList_Item?=nil
    var travelProduct:TravelAgencyProduct_List?=nil
    var count = 0
    let textArray = ["联系人","手机号","备注"]
    let placeholderArray = ["请填写真实姓名","请填写真实号码","请输入备注"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        product_title.text = travelProduct?.Title
        startDate.text = "出发日期 \(model!.DateTime)"
        pepoleCount.text = "共\(count)人"
        price.text = "¥\((model?.Price)!*count)"
        xuzhi.tag = 100
        payforBtn.tag = 101
        
        xuzhi.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
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
            //入住人
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
                let parameters = ["TravelAgencyProductID":travelProduct!.TravelAgencyID,"DateTimeSelectedID":model!.DateTimeSelectedID,"UserID":Global_UserInfo.userid,"Number":count,"SetOutDate":model!.DateTime,"TouristName":(cell0.textField.text)!,"TouristPhone":(cell1.textField.text)!,"Remark":(cell2.textField.text)!] as [String : Any]
                let vc =   PayClass(parameters: parameters,Channels: 4,delegate:self)
                self.present(vc, animated: false, completion: nil)
                print("提交订单")
            }else{
                CommonFunction.HUD("请输入正确的手机号码", type: .error)
            }
            
            break
            
        default:
            break
        }
    }
    //MARK: 创建UI
    func initUI() -> Void {
        tableView.frame = CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64 - 50)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = tableViewHead
        tableView.tableFooterView = UIView.init()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! TravelOderWriteCell
        cell.keyLable.text = textArray[indexPath.row]
        cell.textField.placeholder = placeholderArray[indexPath.row]
        if indexPath.row == 1 {
            cell.textField.keyboardType = .numberPad
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}
