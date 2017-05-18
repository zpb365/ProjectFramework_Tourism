//
//  TravelAcyDateChoose.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyDateChoose: CustomTemplateViewController,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 94, width: self.view.frame.width, height: CommonFunction.kScreenHeight - 94 - 50), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DateCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    lazy var headView: UIView = {
        let weekArr = ["日","一","二","三","四","五","六"]
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: 30))
        headView.backgroundColor = CommonFunction.SystemColor()
        for i in 0..<7 {
            let number = CGFloat(i)*self.view.frame.width / 7
            let weekLab:UILabel = UILabel(frame: CGRect(x: number,y: 0, width: self.view.frame.width/7 ,  height: 30) )
            weekLab.text = weekArr[i]
            weekLab.textColor = UIColor.white
            weekLab.font = UIFont.systemFont(ofSize: 13)
            weekLab.textAlignment = NSTextAlignment.center
            headView.addSubview(weekLab)
        }
        return headView
    }()
    lazy var reservationBtn: UIButton = {
        let reservationBtn = UIButton.init(type: .system)
        reservationBtn.frame = CGRect.init(x: CommonFunction.kScreenWidth - 50, y: 25, width: 50, height: 30)
        reservationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        reservationBtn.setTitle("预定", for: .normal)
        reservationBtn.setTitleColor(UIColor.white, for: .normal)
        reservationBtn.addTarget(self, action: #selector(reservation), for: .touchUpInside)
        return reservationBtn
    }()
    
    lazy var topBar: UIView = {
        let topBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 64))
        topBar.backgroundColor = CommonFunction.SystemColor()
        
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(5, y: 25, w: 40, h: 30)
        backBtn.backgroundColor = UIColor.clear
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        topBar.addSubview(backBtn)
        
        let titleLable = UILabel.init(frame: CGRect.init(x: 0, y: 27, width: 100, height: 20))
        titleLable.center.x = topBar.center.x
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.textColor = UIColor.white
        titleLable.text = "选择日期"
        titleLable.textAlignment = .center
        topBar.addSubview(titleLable)
        
        return topBar
    }()
    lazy var bottomView: UIView = {
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: CommonFunction.kScreenHeight - 50, width: CommonFunction.kScreenWidth, height: 50))
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.borderWidth = 0.7
        bottomView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        let lable = UILabel.init(frame: CGRect.init(x: 5, y: 2, width: 100, height: 20))
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.text = "请选择出行人数"
        bottomView.addSubview(lable)
        let imageView = UIImageView.init(frame: CGRect.init(x: CommonFunction.kScreenWidth - 30, y: 25, width: 20, height: 20))
        imageView.image = UIImage.init(named: "next")
        bottomView.addSubview(imageView)
        return bottomView
    }()
    //出行人数
    lazy var countLable: UILabel = {
        let countLable = UILabel.init(frame: CGRect.init(x: 20, y: 25, width: 50, height: 20))
        countLable.font = UIFont.systemFont(ofSize: 12)
        countLable.text = "1人"
        return countLable
    }()
    var selectedCell:DateCell?
    var ViewModel = TravelDateViewModel()
    var dateArray = Array<Any>()
    var weekArray = Array<Any>()
    var selectedIndex : IndexPath? = nil
    var todayIndex : IndexPath? = nil
    var ScenicID = 0
    var travelProduct:TravelAgencyProduct_List?=nil
    //现在的年月日
    var nowYear = 0
    var nowMonth = 0
    var nowDay = 0
    //保存的日期模型
    var model: ScenicDatePriceList_Item?=nil
    //出行人数
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.topBar)
        self.topBar.addSubview(self.reservationBtn)
        self.view.addSubview(self.headView)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.bottomView)
        self.bottomView.addSubview(self.countLable)
        self.InitCongifCollection(collectionView, nil)
        self.header.isHidden = true
        self.GetHtpsData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        self.title = "选择日期"
        self.view.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        bottomView.addGestureRecognizer(tap)
        
    }
    func tapClick() -> Void {
        var title = Array<String>()
        for i in 0..<10 {
            title.append((i+1).description)
        }
        CommonFunction.ActionSheet(ShowTitle: title,sheetWithTitle:"请选择出行的人数" ,ItemsTextColor: UIColor().TransferStringToColor("#52B0E9"), ReturnSelectedIndex: { (index, str) in
            self.count = index + 1
            self.countLable.text = "\(self.count)人"
        })
    }
    override func Error_Click() {
        self.GetHtpsData()
    }
    //MARK: 获取网络数据
    func GetHtpsData() -> Void {
        bottomView.isHidden = true
        ViewModel.GetTravelAgencySelectedTimeList(TravelAgencyID: travelProduct!.TravelAgencyID, TravelAgencyProductID: travelProduct!.TravelAgencyProductID) { (result) in
            if result == true {
                self.getData()
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
                
            }
        }
    }
    //MARK: 获取数据
    func getData() -> Void {
        let date = DateClass.getNowDate()
        nowDay = date.day
        nowYear = date.year
        nowMonth = date.month
        
        
        for i in 0..<ViewModel.ListData.count {
            let date = DateClass.getCountOfDaysInMonth(year: nowYear, month: nowMonth + i)
            dateArray.append(date.count)
            weekArray.append(date.week)
        }
        self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
        if ViewModel.ListData.count > 0 {
            bottomView.isHidden = false
        }
    }
    //MARK: 预定
    func reservation() -> Void {
        if self.model != nil {
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcyOderWrite", Identifier: "TravelAcyOderWrite") as! TravelAcyOderWrite
            vc.model = self.model
            vc.travelProduct = self.travelProduct
            vc.count = self.count
            self.navigationController?.show(vc, sender: true)
        }else{
            CommonFunction.HUD("请选择有效的日期", type: .error)
        }
    }
    func buttonClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: collectionViewDelegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dateArray.count
    }
    //返回多少个cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = dateArray[section] as! Int
        let week = weekArray[section] as! Int
        
        return  (count+week-1)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCell
        //--------------------------------防止复用导致数据错乱--------------------------------
        cell.dateLable.text = ""
        cell.priceLable.text = ""
        cell.selectorView.isHidden = true
        cell.dateLable.textColor = UIColor.black
        cell.model = nil
        cell.backgroundColor = UIColor.white
        //--------------------------------防止复用导致数据错乱--------------------------------
        
        let currentWeek = weekArray[indexPath.section] as! Int
        if indexPath.item >= currentWeek - 1 {
            let time = indexPath.item - currentWeek + 2
            var isToday = false
            //把今天存进来 今天之前的日期不可选
            if (indexPath.section == 0 && time == nowDay) {
                todayIndex = indexPath
                isToday = true
            }
            //获取系统日期
            cell.setDate(time:time, isToday: isToday)
            //数据赋值
            for i in 0..<(self.ViewModel.ListData[indexPath.section].List?.count)! {
                let model = self.ViewModel.ListData[indexPath.section].List![i]
                if time == model.Day {
                    cell.InitConfig(model)
                }
            }
            //未选择日期的话默认明天是选择的日期
            if (indexPath.section == 0 && time == nowDay + 1 ) {
                if selectedCell == nil {
                    cell.selectored()
                    selectedCell = cell
                    selectedIndex = indexPath
                    if cell.model != nil {
                        self.model = cell.model
                    }
                }
            }
            //选择日期就直接根据选择的index去标记
            if (selectedIndex?.section == indexPath.section && selectedIndex?.item == indexPath.item) {
                cell.selectored()
            }
        }
        //把今天之前的日期标记成灰色
        if (indexPath.item >= currentWeek - 1 && indexPath.item < nowDay + currentWeek - 2 && indexPath.section == 0) {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentWeek = weekArray[indexPath.section] as! Int
        if ((indexPath.section == 0 && indexPath.item < (todayIndex?.item)!) || (indexPath.section != 0 && indexPath.item < currentWeek - 1)) {

            print("今天之前不可选")
        }
        else{
            if selectedIndex != nil {
                self.model = nil
                //获取到点击的model
                let cell = collectionView.cellForItem(at: indexPath) as! DateCell
                if cell.model != nil {
                    self.model = cell.model
                }
                selectedIndex = indexPath
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0,0,0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=7  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        
        return CGSize(width: self.view.bounds.size.width / showrowsitem, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: CommonFunction.kScreenWidth, height: 30)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)as!DateCollectionReusableView
            if nowMonth + indexPath.section <= 12 {
                let str = "\(nowYear)年\(nowMonth + indexPath.section)月"
                head.lable.text = str
            }else{
                let str = "\(nowYear+1)年\(nowMonth + indexPath.section - 12)月"
                head.lable.text = str
                
            }
            return head
        }
        else{
            return UICollectionReusableView()
        }
    }
 

}
