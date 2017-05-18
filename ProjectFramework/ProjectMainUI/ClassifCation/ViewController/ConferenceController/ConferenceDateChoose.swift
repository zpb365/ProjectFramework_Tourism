//
//  ConferenceDateChoose.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceDateChoose: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout{
    
    typealias CallbackValue=(_ value:Array<Int>)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 94, width: self.view.frame.width, height: CommonFunction.kScreenHeight - 94), collectionViewLayout: layout)
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

    var selectedCell:DateCell?
    var dateArray = Array<Any>()
    var weekArray = Array<Any>()
    var selectedIndex : IndexPath? = nil
    var todayIndex : IndexPath? = nil
    var ScenicID = 0
    //现在的年月日
    var nowYear = 0
    var nowMonth = 0
    var nowDay = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.view.addSubview(self.topBar)
        self.view.addSubview(self.headView)
        self.view.addSubview(self.collectionView)
        self.InitCongifCollection(self.collectionView, nil)
        self.header.isHidden = true
        
    }

    //MARK: 获取数据
    func getData() -> Void {
        let date = DateClass.getNowDate()
        nowDay = date.day
        nowYear = date.year
        nowMonth = date.month
        
        for i in 0..<2 {
            let date = DateClass.getCountOfDaysInMonth(year: nowYear, month: nowMonth + i)
            dateArray.append(date.count)
            weekArray.append(date.week)
        }
        self.collectionView.reloadData()
        self.footer.isHidden = true
    }
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

            //未选择日期的话默认明天是选择的日期
            if (indexPath.section == 0 && time == nowDay + 1 ) {
                if selectedCell == nil {
                    cell.selectored()
                    selectedCell = cell
                    selectedIndex = indexPath
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
            var selectArray = Array<Int>()
            let currentWeek = weekArray[indexPath.section] as! Int
            var selectYear = 0
            let selectMoon = indexPath.section + nowMonth
            let selectDay  = indexPath.item - currentWeek + 2
            //不跨年的情况下
            if nowMonth + indexPath.section <= 12{
                selectYear = nowYear
               
            }else{
                selectYear = nowYear + 1
            }
            selectArray.append(selectYear)
            selectArray.append(selectMoon)
            selectArray.append(selectDay)
            if myCallbackValue != nil {
                self.dismiss(animated: true, completion: { 
                    self.myCallbackValue!(selectArray)
                })
            }
        }
    }
    //MARK: UICollectionViewDelegateFlowLayout
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
    //返回按钮
    func buttonClick() -> Void {
        
        self.dismiss(animated: true) {
            
        }
    }

}
