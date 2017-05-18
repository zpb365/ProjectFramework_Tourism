//
//  ScenicSpotHome.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotHome: CustomTemplateViewController,ScrollEnabledDelegate {

    
    typealias CallbackValue=(_ value:Int)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionLable = UILabel()
    var ScenicHomeModel: ScenicHomeItem?=nil
    let titleArray = ["景区资讯","全景","视频","美图","景点"]
    
    let identifier = "ScenicSpotHomeNewsCell"
    let identiFier = "ScenicSpotMainCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()

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
        if ScenicHomeModel == nil {
            self.numberOfSections = 0//显示行数
        }else{
            self.numberOfSections = 5//显示行数
        }
        self.header.isHidden = true
        self.tableView.isScrollEnabled = false//关闭滑动
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }
    //MARK: tableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 35
        }else{
            return 140
        }
    }
   
    var _numberOfRowsInSection = [0,0,0,0,0]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        _numberOfRowsInSection[0] = (ScenicHomeModel?.NewsClass?.ScenicNews?.count)!
        _numberOfRowsInSection[1] = Int((CGFloat((self.ScenicHomeModel?.Panorama360!.count)!) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? ((self.ScenicHomeModel?.Panorama360!.count)!/2)+1:(self.ScenicHomeModel?.Panorama360!.count)!/2
        _numberOfRowsInSection[2] = Int((CGFloat((self.ScenicHomeModel?.VRVideoDTO!.count)!) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? ((self.ScenicHomeModel?.VRVideoDTO!.count)!/2)+1:(self.ScenicHomeModel?.VRVideoDTO!.count)!/2
        _numberOfRowsInSection[3] = Int((CGFloat((self.ScenicHomeModel?.BeautifulPicture!.count)!) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? ((self.ScenicHomeModel?.BeautifulPicture!.count)!/2)+1:(self.ScenicHomeModel?.BeautifulPicture!.count)!/2
        _numberOfRowsInSection[4] = Int((CGFloat((self.ScenicHomeModel?.ScenicAttractions!.count)!) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? ((self.ScenicHomeModel?.ScenicAttractions!.count)!/2)+1:(self.ScenicHomeModel?.ScenicAttractions!.count)!/2
//        print("数组个数",self.ScenicHomeModel.BeautifulPicture!.count)
        return _numberOfRowsInSection[section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScenicSpotHomeNewsCell
            cell.InitConfig(ScenicHomeModel?.NewsClass?.ScenicNews?[indexPath.row] as Any)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("360Panorama", isHiden: false, centerText: " 360°")
            //下标为偶数
            if( (self.ScenicHomeModel?.Panorama360!.count)! > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.Panorama360![(indexPath.row*2+0)] as Any, model2: "",model2isNull: true, type: .PanoramaImage)
            }
            //下标为奇数
            if( (self.ScenicHomeModel?.Panorama360!.count)! > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.Panorama360![(indexPath.row*2+0)] as Any, model2: self.ScenicHomeModel?.Panorama360![(indexPath.row*2+1)] as Any
                    ,model2isNull: false, type: .PanoramaImage)
            }
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("360Panorama", isHiden: false, centerText: "VR")
            //下标为偶数
            if( (self.ScenicHomeModel?.VRVideoDTO!.count)! > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.VRVideoDTO![(indexPath.row*2+0)] as Any, model2: "",model2isNull: true, type: .VRVideo)
            }
            //下标为奇数
            if( (self.ScenicHomeModel?.VRVideoDTO!.count)! > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.VRVideoDTO![(indexPath.row*2+0)] as Any, model2: self.ScenicHomeModel?.VRVideoDTO![(indexPath.row*2+1)] as Any
                    
                    ,model2isNull: false, type: .VRVideo)
            }
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("", isHiden: true, centerText: "")
            //下标为偶数
            if( (self.ScenicHomeModel?.BeautifulPicture!.count)! > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.BeautifulPicture![(indexPath.row*2+0)] as Any, model2: "",model2isNull: true, type: .BeautyImage)
            }
            //下标为奇数
            if( (self.ScenicHomeModel?.BeautifulPicture!.count)! > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.BeautifulPicture![(indexPath.row*2+0)] as Any, model2: self.ScenicHomeModel?.BeautifulPicture![(indexPath.row*2+1)] as Any,model2isNull: false, type: .BeautyImage)
            }
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotMainCell
            cell.setData("", isHiden: true, centerText: "")
            //下标为偶数
            if( (self.ScenicHomeModel?.ScenicAttractions!.count)! > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.ScenicAttractions![(indexPath.row*2+0)] as Any, model2: "",model2isNull: true, type: .Attractions)
            }
            //下标为奇数
            if( (self.ScenicHomeModel?.ScenicAttractions!.count)! > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.setcell(model1: self.ScenicHomeModel?.ScenicAttractions![(indexPath.row*2+0)] as Any, model2: self.ScenicHomeModel?.ScenicAttractions![(indexPath.row*2+1)] as Any,model2isNull: false, type: .Attractions)
            }
            cell.delegate = self
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let vc = InformationViewController()    //点击智慧头条的cell
            vc.title = ScenicHomeModel?.NewsClass?.ScenicNews?[indexPath.row].Title
            vc.Content = (ScenicHomeModel?.NewsClass?.ScenicNews?[indexPath.row].NewsContent)!
            self.navigationController?.show(vc, sender: self)
            break
        default:
            break
        }
    }
    func buttonClick(_ button: UIButton){
        if  myCallbackValue != nil {
            myCallbackValue!(button.tag)
        }
        
    }
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
//        print("实现代理")
        self.tableView.isScrollEnabled = true
    }
    func ScrollEnabledNo() {
//        print("实现代理")
        self.tableView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("景区首页 页面已经销毁")
    }
}
