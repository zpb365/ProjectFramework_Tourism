//
//  RestaurantMenuDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantMenuDetail: UIViewController,UITableViewDelegate,UITableViewDataSource {

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
        payforBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        payforBtn.backgroundColor = UIColor().TransferStringToColor("#FF5722")
        payforBtn.setTitle("立即订购", for: .normal)
        payforBtn.setTitleColor(UIColor.white, for: .normal)
        payforBtn.tag = 101
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return payforBtn
    }()
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuTab: UILabel!
    @IBOutlet weak var headView: UIView!

    let identiFier = "RestaurantMenuCell"
    var ResturantProduct: RestaurantProduct_List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "套餐详情"
        self.initUI()
        
    }
    override func viewDidLayoutSubviews() {
        goumaixuzhiBtn.tag = 100
        payforBtn.tag = 101
        
        menuTitle.text = ResturantProduct.Title
        menuImage.ImageLoad(PostUrl: HttpsUrlImage+ResturantProduct.CoverPhoto)
        menuTab.text = "1/\(ResturantProduct.Menu!.count)"
        payforBtn.setTitle("¥\(ResturantProduct.DefaultPrice)  立即订购", for: .normal)
        
        let  tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        menuImage.isUserInteractionEnabled = true
        menuImage.addGestureRecognizer(tap)
    }
    func tapClick() -> Void {
        if (ResturantProduct.ImageList?.count)! > 0 {
            var Imagelist = Array<String>()//图片组
            var ImageTab  = Array<String>()//标签组
            for i in 0..<(ResturantProduct.ImageList?.count)! {
                let model = ResturantProduct.ImageList?[i]
                Imagelist.append(HttpsUrlImage+model!.PhotoUrl)
                ImageTab.append(model!.PhotoDescribe)
            }
            let vc = ImagePreviewViewController( ImageUrlList: Imagelist ,IsDescribe: true,DescribeList: ImageTab )
            self.navigationController?.pushViewController(vc, animated: true )
            
        }
    }
    func initUI() -> Void {
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight  - 40)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = headView
        if ResturantProduct.Description != "" {
            let height = ResturantProduct.Description.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 30, height: 0)).height + 50
            let footView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: height))
            let lable = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: CommonFunction.kScreenWidth - 30, height: height))
            lable.font = UIFont.systemFont(ofSize: 11)
            lable.numberOfLines = 0
            footView.addSubview(lable)
            lable.text = ResturantProduct.Description
            self.tableView.tableFooterView = footView
        }else{
            self.tableView.tableFooterView = UIView.init()
        }
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
    func buttonClick(button: UIButton) -> Void{
        switch button.tag {
        case 100:
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 101:
            let vc = CommonFunction.ViewControllerWithStoryboardName("RestaurantOderWrite", Identifier: "RestaurantOderWrite") as! RestaurantOderWrite
            vc.ResturantProduct = self.ResturantProduct
            self.navigationController?.show(vc, sender: self  )
            break
        default:
            break
        }
    }
    //MARK: tableViewDelegate
    let textArray = ["套餐详情","套餐描述"]
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView().setIntroduceView(height: 40, title: textArray[section])
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 30
        }else{
            return 0
        }
        
    }
    var _numberOfRowsInSection = [0,0]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _numberOfRowsInSection[0] = (ResturantProduct.Menu?.count)! + 1
        return _numberOfRowsInSection[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! RestaurantMenuCell
            if indexPath.row == 0 {
                cell.menuName.text = "菜单"
                cell.menuPrice.text = "价格"
                cell.menuCount.text = "数量/规格"
            }else{
                cell.InitConfig(ResturantProduct.Menu?[indexPath.row - 1] as Any)
            }
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
}
