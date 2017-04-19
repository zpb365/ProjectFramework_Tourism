//
//  ScenicSpotHome.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotHome: CustomTemplateViewController {

    
    typealias CallbackValue=(_ value:Int)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionLable = UILabel()
    
    let titleArray = ["景区资讯","全景","视频","美图","景点"]
    
    let identifier = "ScenicSpotHomeNewsCell"
    let identiFier = "ScenicSpotMainCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: initUI
    func initUI(){
        tableView.register(UINib(nibName: "ScenicSpotHomeNewsCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.InitCongif(tableView)
        self.tableView.frame = self.view.bounds
        self.numberOfSections = 5//显示行数
        
    }
    //MARK: tableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 35
        }else{
            return 140
        }
    }
    var _numberOfRowsInSection = [3,2,2,2,2]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsInSection[section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScenicSpotHomeNewsCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("360Panorama", isHiden: false, centerText: " 360°")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("360Panorama", isHiden: false, centerText: "VR")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("", isHiden: true, centerText: "")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("", isHiden: true, centerText: "")
            return cell
        default:
            
            break
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let sectionView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: self.titleArray[section], titleColor: UIColor.black)
        let moreButton = UIButton(type: .custom)
        moreButton.frame = CGRect.init(x: CommonFunction.kScreenWidth - 80, y: 2, width: 70, height: 30)
        moreButton.setTitleColor(UIColor.black, for: .normal)
        moreButton.setTitle("更多", for: .normal)
        moreButton.setImage(UIImage.init(named: "icon_chose_arrow_sel"), for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moreButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -60)
        moreButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        moreButton.tag = 100 + section
        moreButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        sectionView.addSubview(moreButton)
        return sectionView
    }
    func buttonClick(_ button: UIButton){
        if  myCallbackValue != nil {
            myCallbackValue!(button.tag)
        }
        
    }
}
