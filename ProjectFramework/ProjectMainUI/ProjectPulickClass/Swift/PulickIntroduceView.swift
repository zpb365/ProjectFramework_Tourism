//
//  PulickIntroduceView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/22.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PulickIntroduceView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    typealias CallbackValue=(_ value:CGFloat)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    lazy var headView: UIView={
        let headView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 0.01))
        headView.backgroundColor = UIColor.white
        headView.clipsToBounds = true
        return headView
    }()
    //头部标题
    lazy var titleLable: UILabel = {
        let titleLable = UILabel.init()
        titleLable.font = UIFont.systemFont(ofSize: 13)
        return titleLable
    }()
    //头部详情
    lazy var detailLable: UILabel = {
        let detailLable = UILabel.init()
        detailLable.font = UIFont.systemFont(ofSize: 11)
        detailLable.textColor = UIColor.black
        detailLable.numberOfLines = 0
        return detailLable
    }()
    var customTableView: UITableView!
    var sectionArray = [DescribeName_List]()
    let identiFier = "PulickIntroduceCell"//政策和设施服务那些

    
    
    
    func createTableView(frame:CGRect) -> Void {
        customTableView = UITableView.init(frame: frame, style: .grouped)
        customTableView.backgroundColor = UIColor.white
        customTableView.showsVerticalScrollIndicator = false
        customTableView.showsHorizontalScrollIndicator = false
        customTableView.separatorStyle = .none
        customTableView.bounces = false
        customTableView.delegate = self
        customTableView.dataSource = self
        customTableView.tableHeaderView = self.headView
        customTableView.tableFooterView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: 0, h: 0.01))
        self.addSubview(customTableView)
        self.headView.addSubview(self.titleLable)
        self.headView.addSubview(self.detailLable)
        customTableView.register(PulickIntroduceCell.self, forCellReuseIdentifier: identiFier)
        
    }
    
    
    //MARK: 传值回调
    func setData( object:Any ) -> Void {
//        let text = "酒店介绍"
//        
//        let str = "南宁迪拜七星酒店 是昌龙集团旗下的五星级酒店，迪拜七星酒店位于南宁市民族大道竹溪立交东北侧；金融、政治、文化、中心的航洋商圈；东盟国际会展中心正对面，民族大道127号铂宫国际商业大楼内，占地面积约2万平方米。它是结合京城四大会所成功经营管理模式，与国际俱乐部组织接轨共同打造具有广西特色超级豪华型的会员式精品酒店"
//        let height = str.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 20, height: 0)).height
//        self.headView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height + 40)
//        self.titleLable.frame = CommonFunction.CGRect_fram(15, y: 12.5, w: 100, h:15 )
//        self.detailLable.frame = CommonFunction.CGRect_fram(10, y: 40, w: CommonFunction.kScreenWidth - 20, h: height)
//        self.titleLable.text = text
//        self.detailLable.text = str
        
        self.sectionArray = object as! [DescribeName_List]
        
        if (myCallbackValue != nil) {
            customTableView.reloadData()
            myCallbackValue!(customTableView.contentSize.height)
        }
    }

    //MARK: tableViewDelegate && tableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int{
        if (self.sectionArray.count) > 0 {
//            print((self.sectionArray.count))
        }
        return (self.sectionArray.count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.sectionArray[section].List?.count)!
    }
    //组头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if (self.sectionArray.count) > 0 {
            let header = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 30))
            header.backgroundColor = UIColor.white
            let lable = UILabel.init(frame: CommonFunction.CGRect_fram(15, y: 7.5, w: 100, h:15 ))
            lable.font = UIFont.systemFont(ofSize: 14)
            lable.text = self.sectionArray[section].Name
            lable.textColor = CommonFunction.SystemColor()
            header.addSubview(lable)
            return header
        }
        else{
            return UIView()
        }
    }
    //组头高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.sectionArray.count) > 0 ? 30 : 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if (self.sectionArray[indexPath.section].List?.count)! > 0 {
            let model = self.sectionArray[indexPath.section].List?[indexPath.row]
            return model!.Describel.ContentSize(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize(width: CommonFunction.kScreenWidth - 30, height: 0)).height + 40
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PulickIntroduceCell.init(style: .subtitle, reuseIdentifier: identiFier)
        cell.selectionStyle = .none
        if (self.sectionArray[indexPath.section].List?.count)! > 0 {
            cell.InitConfig(self.sectionArray[indexPath.section].List?[indexPath.row] as Any)
        }
        return cell
    }
}
