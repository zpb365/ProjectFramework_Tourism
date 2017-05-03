//
//  HotelFacilities.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelFacilities: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var goumaixuzhiBtn: UIButton = {
       let goumaixuzhiBtn = UIButton.init(type: .system)
        goumaixuzhiBtn.backgroundColor = UIColor.white
        goumaixuzhiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        goumaixuzhiBtn.setTitle("购买须知", for: .normal)
        goumaixuzhiBtn.setTitleColor(UIColor().TransferStringToColor("#5E7D8A"), for: .normal)
        goumaixuzhiBtn.tag = 100
        goumaixuzhiBtn.layer.borderWidth = 0.8
        goumaixuzhiBtn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        goumaixuzhiBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return goumaixuzhiBtn
    }()
    lazy var payforBtn: UIButton = {
        let payforBtn = UIButton.init(type: .system)
        payforBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        payforBtn.backgroundColor = UIColor().TransferStringToColor("#FF5722")
        payforBtn.setTitle("立即订购", for: .normal)
        payforBtn.setTitleColor(UIColor.white, for: .normal)
        payforBtn.tag = 101
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return payforBtn
    }()
    //购买须知文本
    lazy var instructionsView: UIView = {
        let instructionsView = UIView()
        instructionsView.backgroundColor = UIColor.white
        return instructionsView
    }()
    lazy var lable: UILabel = {
        let lable = UILabel()
        lable.text = "购买须知"
        lable.font = UIFont.systemFont(ofSize: 12)
        return lable
    }()
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor().TransferStringToColor("#F0F0F2")
        textView.text = "1.正确选择酒店：根据公司差旅政策选择重点城市的协议酒店。员工可以根据出差地的具体位置，与差旅平台中标志性建筑或当地公司等信息相匹配后搜索酒店资源并选择符合出差标准的酒店下单。差旅平台所提供的会员酒店资源目前正处于系统维护中，可以通过国旅服务热线进行预订。2.协议价格使用：a差旅平台首页有“经济型酒店”专区。登陆后点击链接可查询宝钢已签集团大客户协议的酒店资源、对应协议折扣及优惠条件（链接所显示的酒店官网价格属于散客门市价）。预订可通过国旅服务热线进行预订。b隔月预订差旅协议酒店，由于部分酒店资源会有阶段性变价，最终请以国旅确认短信为准。3.通常情况下酒店在房态紧张的情况下会要求客人预支房款。例如：特殊时期、大型展会活动（旅游文化节等）、黄金周期间。a在国旅确认订单成功生成同时，此类订单是需要全额支付房费。如未在指定最晚时间之前付款，订单将自动取消。b如客人在酒店前台延住，请通知国旅客服，否则将无法继续享受优惠价格，出现的价格分歧国旅将不负任何责任。c正常情况下订单成功支付后是不可以取消及变更。如遇不可抗力因素需要取消订单，请及时联系国旅客服，我们将尽力与酒店协调，最终以酒店回复为准。（担保订单开具的是“宝钢集团上海国际旅行社”提供的发票）"
        return textView
    }()
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton.init(type: .custom)
        deleteBtn.tag = 102
        deleteBtn.setImage(UIImage.init(named: "delete"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return deleteBtn
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var headImage: UIImageView!
    
    let identiFier = "PulickIntroduceCell"//政策和设施服务那些
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "酒店设施"
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    //MARK: 图片点击事件
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        let urllist=["http://pic9.nipic.com/20100902/2029588_234330095230_2.jpg"
            ,"http://pic1a.nipic.com/2008-08-26/200882614319401_2.jpg"
            ,"http://www.ahhnh.com/data/upload/2015-10/2015101940975833.jpg"
            ,"http://pic10.nipic.com/20100929/4879567_114926982000_2.jpg"
            ,"http://img2.imgtn.bdimg.com/it/u=2081796248,4191591232&fm=21&gp=0.jpg"]
        let describeList=["张三","李四","李四","李四","李四"]
        let vc = ImagePreviewViewController( ImageUrlList: urllist ,IsDescribe: true,DescribeList: describeList )
        self.navigationController?.pushViewController(vc, animated: true )
    }
    //MARK: initUI
    func initUI() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: self.view.frame.height - 40 )
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.register(PulickIntroduceCell.self, forCellReuseIdentifier: identiFier)
        
        //添加手势
        headImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        headImage.addGestureRecognizer(tap)
        
        //--------------------------------添加约束--------------------------------
        self.view.addSubview(goumaixuzhiBtn)
        self.view.addSubview(payforBtn)
        
        goumaixuzhiBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)//宽高相等
            make.left.equalTo(0)//右边相对父控件的约束条件r
            make.bottom.equalTo(0)//底部相对父控件的约束条件
            make.height.equalTo(40)
        }
        payforBtn.snp.makeConstraints { (make) in
            make.left.equalTo(goumaixuzhiBtn.snp.right).offset(0)
            make.right.equalTo(0)//右边相对父控件的约束条件
            make.bottom.equalTo(0)//底部相对父控件的约束条件
            make.height.equalTo(40)
        }

    }
    //MARK: buttonClick
    func buttonClick(button: UIButton) -> Void {
        if button.tag == 100 {
            self.showInstructionsView()
        }
        if button.tag == 102 {
            instructionsView.removeFromSuperview()
        }
    }
    //MARK: 购买须知
    func showInstructionsView() -> Void {
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(instructionsView)
        instructionsView.addSubview(lable)
        instructionsView.addSubview(deleteBtn)
        instructionsView.addSubview(textView)
        
        instructionsView.snp.makeConstraints { (make) in
            make.left.equalTo(0)//宽高相等
            make.top.equalTo(0)//右边相对父控件的约束条件r
            make.bottom.equalTo(0)//底部相对父控件的约束条件
            make.right.equalTo(0)
        }
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(10)//宽高相等
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(80)//底部相对父控件的约束条件
            make.height.equalTo(20)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(40)//底部相对父控件的约束条件
            make.height.equalTo(30)
            make.right.equalTo(0)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(40)//右边相对父控件的约束条件r
            make.left.equalTo(0)//底部相对父控件的约束条件
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    //MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let str = "我是自适应文本我是自"
        return str.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 20, height: 0)).height + 35
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PulickIntroduceCell.init(style: .subtitle, reuseIdentifier: identiFier)
        cell.selectionStyle = .none
        cell.InitConfig("我是自适应文本我是自")
        return cell
    }
}
