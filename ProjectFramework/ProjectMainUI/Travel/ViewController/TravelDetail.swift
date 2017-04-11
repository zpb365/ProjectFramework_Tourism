//
//  TravelDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelDetail: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var customWeb: PulickWebView = {
        let customWeb = PulickWebView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 50))
        customWeb.FuncCallbackValue { [weak self] (height) in
            self?.customWeb.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: height)
            self?.height = height
            self?.tableView.reloadData()
        }
        return customWeb
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var CustomNavBar:UINavigationBar!=nil
    var height: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //MARK: 获取数据
    func getData() -> Void {
        self.customWeb.loadHtmlString(html: "<p>香蕉是淀粉质丰富的有益水果。味甘性寒，可清热润肠</p><p>香蕉</p><p>香蕉</p><p>，促进肠胃蠕动，但脾虚泄泻者却不宜。根据“热者寒之”的原理，最适合燥热人士享用。痔疮出血者、因燥热而致胎动不安者，都可生吃蕉肉。</p><p>民间验方更有用香蕉炖冰糖，医治久咳；用香蕉煮酒，作为食疗。近代医学建议，用香蕉可治高血压，因它含钾量丰富，可平衡钠的不良作用，并促进细胞及组织生长。用香蕉可治疗便秘，因它能促进肠胃蠕动。</p><p>早餐午餐和晚餐分别吃一根香蕉，能够为人体提供丰富的钾，从而使得大脑血凝块几率降低约21%。</p><p>德国研究人员表示，用香蕉可治抑郁和情绪不安，因它能促进大脑分泌内啡化学物质。它能缓和紧张的情绪，提高工作效率，降低疲劳。</p><p>营养价值</p><p>香蕉属高热量水果，据分析每100克果肉的发热量达91大卡。在一些热带地区香蕉还作为主要粮食。香蕉果肉营</p><p>养价值颇高，每100克果肉含碳水化合物20克、蛋白质1.2克、脂肪0.6克；此外，还含多种微量元素和维生素。其中维生素A能促进生长，增强对疾病的抵抗力，是维持正常的生殖力和视力所必需；硫胺素能抗脚气病，促进食欲、助消化，保护神经系统；核黄素能促进人体正常生长和发育。　香蕉除了能平稳血清素和褪黑素外，它还含有可具有让肌肉松弛效果的镁元素，经常工作压力比较大的朋友可以多食用。</p>")
    }
    //MARK: initUI
    func initUI() -> Void {
        BaseView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: contentLabel.frame.maxY + 20 )        
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(-20)
            make.bottom.equalTo(0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //赋值头部
        tableView.tableHeaderView = BaseView
//        tableView.tableFooterView = self.customWeb
    }
    //MARK: 设置导航栏
    func setNavBar() -> Void{
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor.clear, size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    //MARK: tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return self.customWeb
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return height > 50 ? height : 50
    }
}
