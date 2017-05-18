//
//  ScenicSpotOderWrite.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotOderWrite: UIViewController,UITextFieldDelegate {
    
    

    @IBOutlet weak var detailLable: UILabel!//票详情
    @IBOutlet weak var priceLable: UILabel!//票单价
    @IBOutlet weak var numberLable: UILabel!//数量
    @IBOutlet weak var trueNameTextField: UITextField!//真实姓名
    @IBOutlet weak var phoneTextField: UITextField!//手机号码
    @IBOutlet weak var totalPricrLable: UILabel!//总金钱
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var zhixuBtn: UIButton!//购买须知
    @IBOutlet weak var payforBtn: UIButton!//支付订单
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    
    
    var ticketItem: ScenicTicketList?=nil
    var timeModel: ScenicDatePriceList_Item?=nil
    var Number = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //加载子视图
    override func viewDidLayoutSubviews() {
        backbtn.tag     = 100
        zhixuBtn.tag    = 101
        payforBtn.tag   = 102
        nextBtn.tag     = 103
        
        backbtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        zhixuBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        trueNameTextField.delegate = self
        phoneTextField.delegate    = self
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        nextView.addGestureRecognizer(tap)
        
        
    }
    func tapClick() -> Void {
        var title = [String]()
        for i in 0..<10 {
            title.append((i+1).description)
        }
        CommonFunction.ActionSheet(ShowTitle: title,sheetWithTitle:"请选择购买的张数" ,ItemsTextColor: UIColor().TransferStringToColor("#52B0E9"), ReturnSelectedIndex: { (index, string) in
            self.Number = index + 1
            self.setData()
        })
        print("下一步")
    }
    //MARK: 设置数据
    func setData() -> Void {
        detailLable.text     = ticketItem?.Title
        priceLable.text      = "¥\(timeModel!.Price)/张"
        timeLable.text       = "\(timeModel!.Yeas)-\(timeModel!.Month)-\(timeModel!.Day)"
        numberLable.text     = "\(Number)张"
        totalPricrLable.text = "¥\(timeModel!.Price*Number)"
    }
    //MARK: buttonClick
    func buttonClick( button:UIButton) -> Void {
        switch button.tag {
        case 100:
            CommonFunction.AlertController(self, title: "取消订单", message: "您暂未支付该订单，是否要取消订单？", ok_name: "确定", cancel_name: "取消", OK_Callback: {
                    self.navigationController?.popViewController(animated: true)

            }, Cancel_Callback: {
                
            })
            break
        case 101:
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 102:
            //是否登录
            if(Global_UserInfo.IsLogin==false){
                let vc = LoginViewControllerTwo()
                self.present(vc, animated: true, completion: nil)
                return
            }
            
            var canPayfor: Bool = false//是否能支付
            if trueNameTextField.text == "" {
                CommonFunction.HUD("请输入真实姓名", type: .error)
                return
            }
            canPayfor = Validate.phoneNum(phoneTextField.text!).isRight
            if canPayfor == true {
                //判断是否有库存
                if Number > self.timeModel!.Inventory {
                    CommonFunction.HUD("您购买的票库存不足\(Number)张",type: .error)
                }else{
                    let parameters = ["ScenicProductID":(ticketItem?.ScenicProductID)!,"UserID":Global_UserInfo.userid,"Number":Number,"DateTimeSelectedID":(timeModel?.DateTimeSelectedID)!,"TouristName":(trueNameTextField.text)!,"TouristPhone":(phoneTextField.text)!,"Remark":""] as [String : Any]
                    let vc =   PayClass(parameters: parameters,Channels: 1,delegate:self)
                    self.present(vc, animated: false, completion: nil)
                }
                
            }else{
                CommonFunction.HUD("请输入正确的手机号码", type: .error)
                return
            }
            break
        case 103:
            var title = [String]()
            for i in 0..<10 {
                title.append(i.description)
            }
            CommonFunction.ActionSheet(ShowTitle: title,sheetWithTitle:"请选择购买的张数" ,ItemsTextColor: UIColor().TransferStringToColor("#52B0E9"), ReturnSelectedIndex: { (index, string) in
                self.Number = index
                self.setData()
            })
            print("下一步")
            break
        default: break
            
        }
    }
    //点击屏幕
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: textFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //真实姓名
        if textField.tag == 1 {
            trueNameTextField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        }
        if textField.tag == 2 {
            self.view.endEditing(true)
        }
        return true
    }
    
    deinit {
        print("shifangle")
        
    }
}
