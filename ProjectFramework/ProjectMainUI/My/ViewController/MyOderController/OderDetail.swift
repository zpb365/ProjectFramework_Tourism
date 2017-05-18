//
//  OderDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class OderDetail: CustomTemplateViewController {

    lazy var bottomBar: UIView = {
        let bottomBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: CommonFunction.kScreenHeight - 40, w: CommonFunction.kScreenWidth, h: 40))
        bottomBar.backgroundColor = UIColor().TransferStringToColor("#F8F8F8")
        bottomBar.layer.borderWidth = 0.5
        bottomBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        
        let payLable = UILabel.init(frame: CommonFunction.CGRect_fram(5, y: (40 - 15)/2, w: 75, h: 15))
        payLable.font = UIFont.systemFont(ofSize: 13)
        payLable.text = "支付金额"
        payLable.textColor = UIColor.gray
        bottomBar.addSubview(payLable)
        
        return bottomBar
    }()
    
    //支付金额
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel.init(frame: CommonFunction.CGRect_fram(80, y: (40 - 15)/2, w: 100, h:15 ))
        priceLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.text = "¥999"
        priceLabel.textColor = UIColor().TransferStringToColor("#FF5722")
        return priceLabel
    }()
    
    lazy var typeButton: UIButton = {
        let typeButton = UIButton.init(type: .system)
        typeButton.frame = CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 90, y: 0, w: 90, h: 40)
        typeButton.backgroundColor = UIColor().TransferStringToColor("#FF5722")
        typeButton.setTitle("待评价", for: .normal)
        typeButton.setTitleColor(UIColor.white, for: .normal)
        typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        typeButton.addTarget(self, action: #selector(buttonClick(_ :)), for: .touchUpInside)
        return typeButton
    }()
    
    
    @IBOutlet weak var tabbleView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    
    @IBOutlet weak var Pic: UIImageView!
    
    @IBOutlet weak var S_Title: UILabel!
    
    @IBOutlet weak var ProductTitle: UILabel!
    
    @IBOutlet weak var Describe: UILabel!
    
    @IBOutlet weak var S_OrderNumber: UILabel!
    
    @IBOutlet weak var CreationTime: UILabel!
    
    @IBOutlet weak var PayType: UILabel!
    
    let identiFier = "OderContactCell"
    
    var OrderNumber=""  //订单号
    
    var _MyOrderModel:MyOrderModel?  //订单列表模型
    
    let viewModel = MyOrderDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        GetHtpsData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: initUI
    func initUI() -> Void {
        self.title = "订单详情"
        
        self.InitCongif(self.tabbleView)
        self.tabbleView.frame = CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 64 - 40)
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 40
        self.header.isHidden = true
        self.Backfooter.isHidden = true
        self.tabbleView.tableFooterView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 0.001))
        self.view.addSubview(self.bottomBar)
        self.bottomBar.addSubview(self.priceLabel)
        self.bottomBar.addSubview(self.typeButton)
    }
    
    //MARK: 获取数据
    func GetHtpsData() {
        
        self.tableViewHead.isHidden=true
        self.bottomBar.isHidden=true
        viewModel.GetMyOrderDetails(OrderNumber:self.OrderNumber) { (result,NoMore) in
            if  result == true {
                
                if(NoMore==true){
                     self.numberOfRowsInSection=0
                 self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                }else{
                    self.tableViewHead.isHidden=false
                    self.bottomBar.isHidden=false
                     self.tabbleView.tableHeaderView = self.tableViewHead
                     self.numberOfRowsInSection=4
                    self.SetUIData()
                    self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                }
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    override func Error_Click() {
        GetHtpsData()
    }
    
    //设置UI数据
    func SetUIData(){
         
        Pic.ImageLoad(PostUrl:  HttpsUrlImage+Global_UserInfo.HeadImgPath)
        S_Title.text=viewModel.ListData.Title
        ProductTitle.text=viewModel.ListData.TitleProduct
        Describe.text=viewModel.ListData.Describe
        S_OrderNumber.text="订单编号:"+viewModel.ListData.OrderNumber
        CreationTime.text="创建时间:"+viewModel.ListData.S_CreateTime
        PayType.text="支付类型:"+viewModel.ListData.PayType
        priceLabel.text=viewModel.ListData.OrderAmount.description
        
        if(_MyOrderModel?.IsPay=="1"&&_MyOrderModel?.Isevaluate=="0"){    //是否待付款
            typeButton.setTitle("待付款", for: .normal)
            typeButton.tag=0   //0 代表付款
        }
        if(_MyOrderModel?.IsPay=="0"&&_MyOrderModel?.Isevaluate=="1"){    //是否待付款
            typeButton.setTitle("待评价", for: .normal)
            typeButton.tag=1   //1 代表评价
        }
        if(_MyOrderModel?.IsPay=="0"&&_MyOrderModel?.Isevaluate=="0"){
            typeButton.isHidden = true
        }
    }
    
    
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! OderContactCell
        switch indexPath.row {
        case 0:
             cell.setCell(key: "联系人", value:viewModel.ListData.TouristName)
            break
        case 1:
            cell.setCell(key: "联系电话", value:viewModel.ListData.TouristPhone)
            break
        case 2:
            cell.setCell(key: "备注", value:viewModel.ListData.Remark)
            break
        case 3:
            cell.setCell(key: "", value:"")
            break
        default:
            break
        }
       
        return cell
    }
    //MARK: 支付类型
    func buttonClick(_ sender: UIButton) -> Void {
        if(sender.tag==0){  //待付款
           let vc =   PayClass(parameters: ["OrderNumber":viewModel.ListData.OrderNumber],Channels: 0,delegate:self)
            self.present(vc, animated: false, completion: nil)
        }
        if(sender.tag==1){  //待评价
            let vc = CommonFunction.ViewControllerWithStoryboardName("OderComment", Identifier: "OderComment") as! OderComment
            vc._OrderNumber=viewModel.ListData.OrderNumber
            self.navigationController?.show(vc, sender: self  )
        }
        
    }
}
