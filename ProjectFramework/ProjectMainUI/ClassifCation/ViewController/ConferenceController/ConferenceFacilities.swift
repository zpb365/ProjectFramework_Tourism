//
//  ConferenceFacilities.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceFacilities: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var countLable: UILabel!
    
    let identiFier = "PulickIntroduceCell"//政策和设施服务那些
    var MeetingProduct:MeetingProduct_List?=nil
    var SelectDateTime=""
    var TimeInterval=0
    var timeStr = ""
    var year=0
    var moon=0
    var day=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "酒店设施"
        self.initUI()
    }
    override func viewDidLayoutSubviews() {
        titleName.text = MeetingProduct?.Title
        headImage.ImageLoad(PostUrl: HttpsUrlImage+MeetingProduct!.CoverPhoto)
        if (MeetingProduct?.ImageList?.count)! > 0 {
            countLable.text = " 1/\((MeetingProduct?.ImageList?.count)!)"
        }
        payforBtn.setTitle("¥\(MeetingProduct!.Price)  立即订购", for: .normal)
        
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
    //MARK: 图片点击事件
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        
        if (MeetingProduct?.ImageList?.count)! > 0 {
            var Imagelist = Array<String>()//图片组
            var ImageTab  = Array<String>()//标签组
            for i in 0..<(MeetingProduct?.ImageList?.count)! {
                let model = MeetingProduct?.ImageList?[i]
                Imagelist.append(HttpsUrlImage+model!.PhotoUrl)
                ImageTab.append(model!.PhotoDescribe)
            }
            let vc = ImagePreviewViewController( ImageUrlList: Imagelist ,IsDescribe: true,DescribeList: ImageTab )
            self.navigationController?.pushViewController(vc, animated: true )
            
        }
    }
    //MARK: buttonClick
    func buttonClick(button: UIButton) -> Void {
        switch button.tag {
        case 100:
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 101:
            if MeetingProduct?.IsInventory == true {
                let vc = CommonFunction.ViewControllerWithStoryboardName("ConferenceOderWrite", Identifier: "ConferenceOderWrite") as! ConferenceOderWrite
                vc.MeetingProduct = self.MeetingProduct
                vc.timeStr = self.timeStr
                vc.TimeInterval = self.TimeInterval
                vc.SelectDateTime = self.SelectDateTime
                vc.year = self.year
                vc.moon = self.moon
                vc.day  = self.day
                self.navigationController?.show(vc, sender: self)
            }else{
                CommonFunction.HUD("该产品暂无库存！", type: .error)
            }
            
            break
        default:
            break
        }
    }
    //MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MeetingProduct?.DescribeName?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if (MeetingProduct?.DescribeName?.count)! > 0 {
            return (MeetingProduct?.DescribeName?[indexPath.row].Describel.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 20, height: 0)).height)! + 35
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PulickIntroduceCell.init(style: .subtitle, reuseIdentifier: identiFier)
        cell.selectionStyle = .none
        if (MeetingProduct?.DescribeName?.count)! > 0 {
            cell.InitConfig(MeetingProduct?.DescribeName?[indexPath.row] as Any)
        }
        return cell
    }

}
