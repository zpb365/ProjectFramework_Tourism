//
//  ConferenceOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceOderWrite: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var product_Tab: UILabel!
    @IBOutlet weak var xuzhi: UIButton!
    @IBOutlet weak var payforBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var timeInterValLable: UILabel!
    
    let identiFier = "ConferenceOderWriteCell"
    let textArray = ["联系人","手机号","备注"]
    let placeholderArray = ["请填写真实姓名","请填写真实号码","请输入备注"]
    var MeetingProduct:MeetingProduct_List!
    var SelectDateTime=""
    var TimeInterval=0
    var timeStr = ""
    var year=0
    var moon=0
    var day=0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单填写"
        self.initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#CCCCCC").withAlphaComponent(0.8), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    override func viewDidLayoutSubviews() {
        baseView.layer.cornerRadius = 5
        productName.text = MeetingProduct.Title
        product_Tab.text = "\(MeetingProduct.Acreage) | \(MeetingProduct.Capacity)  | \(MeetingProduct.AdditionalServices)"
        price.text = "¥\(MeetingProduct.Price)"
        dateLable.text = "\(moon)月\(day)日"
        timeInterValLable.text = timeStr
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
            let cell0 = tableView.cellForRow(at: index0) as! ConferenceOderWriteCell
            //电话号码
            let index1 = IndexPath.init(row: 1, section: 0)
            let cell1 = tableView.cellForRow(at: index1) as! ConferenceOderWriteCell
            //备注
            let index2 = IndexPath.init(row: 2, section: 0)
            let cell2 = tableView.cellForRow(at: index2) as! ConferenceOderWriteCell
            
            if cell0.textField.text == "" {
                CommonFunction.HUD("请输入真实姓名", type: .error)
                return
            }
            canPayfor = Validate.phoneNum(cell1.textField.text!).isRight
            if canPayfor == true {
                let parameters = ["MeetingProductID":MeetingProduct.MeetingProductID,"SubscribeDateTime":SelectDateTime,"UserID":Global_UserInfo.userid,"TimeInterval":TimeInterval,"TouristName":(cell0.textField.text)!,"TouristPhone":(cell1.textField.text)!,"Remark":(cell2.textField.text)!] as [String : Any]
                
                let vc =   PayClass(parameters: parameters,Channels: 5,delegate:self)
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

    func initUI() -> Void {
        tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 50)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ConferenceOderWriteCell
        cell.keyLable.text = textArray[indexPath.row]
        cell.textField.placeholder = placeholderArray[indexPath.row]
        if indexPath.row == 1 {
            cell.textField.keyboardType = .numberPad
        }
        return cell
    }
}
