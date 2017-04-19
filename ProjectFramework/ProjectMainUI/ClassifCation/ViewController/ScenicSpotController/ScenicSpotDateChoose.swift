//
//  ViewController.swift
//  日期控件
//
//  Created by 住朋购友 on 2017/3/30.
//  Copyright © 2017年 LYF. All rights reserved.
//

import UIKit

class ScenicSpotDateChoose: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.view.frame.width/7, height: 50)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 94, width: self.view.frame.width, height: CommonFunction.kScreenHeight - 94), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DateCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    lazy var headView: UIView = {
        let weekArr = ["日","一","二","三","四","五","六"]
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: 30))
        headView.backgroundColor = UIColor().TransferStringToColor("#52B0E9")
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
        reservationBtn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
        reservationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        reservationBtn.setTitle("预定", for: .normal)
        reservationBtn.setTitleColor(UIColor.white, for: .normal)
        reservationBtn.addTarget(self, action: #selector(reservation), for: .touchUpInside)
        return reservationBtn
    }()

    //
    var selectedCell:DateCell?
    //    var head = DateCollectionReusableView()
    var dateArray = Array<Any>()
    var weekArray = Array<Any>()
    var selectedIndex : IndexPath? = nil
    var todayIndex : IndexPath? = nil
    
    //现在的年月日
    var nowYear = 0
    var nowMonth = 0
    var nowDay = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.reservationBtn)
        self.getData()
        self.view.addSubview(self.headView)
        self.view.addSubview(self.collectionView)
    }
    //MARK: 预定
    func reservation() -> Void {
        let moon = (selectedIndex?.section)! + nowMonth
        let Week = weekArray[(selectedIndex?.section)!] as! Int
        let day = (selectedIndex?.item)! - Week + 2
        print(moon,day)
    }

    //MARK: 获取数据
    func getData() -> Void {
        let date = DateClass.getNowDate()
        nowDay = date.day
        nowYear = date.year
        nowMonth = date.month
        
        
        for i in 0..<3 {
            let date = DateClass.getCountOfDaysInMonth(year: nowYear, month: nowMonth + i)
            dateArray.append(date.count)
            weekArray.append(date.week)
        }
        self.collectionView.reloadData()
    }
    
    //MARK: collectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dateArray.count
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = dateArray[section] as! Int
        let week = weekArray[section] as! Int
        
        return  (count+week-1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCell
        //--------------------------------防止复用导致数据错乱--------------------------------
        cell.dateLable.text = ""
        cell.priceLable.text = ""
        cell.selectorView.isHidden = true
        cell.dateLable.textColor = UIColor.black
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
            cell.setDate(time: time, isToday: isToday)
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
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentWeek = weekArray[indexPath.section] as! Int
        if ((indexPath.section == 0 && indexPath.item < (todayIndex?.item)!) || (indexPath.section != 0 && indexPath.item < currentWeek - 1)) {
            print("今天之前不可选")
        }
        else{
            if selectedIndex != nil {
                selectedIndex = indexPath
                self.collectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0,0,0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: CommonFunction.kScreenWidth, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)as!DateCollectionReusableView
            let str = "\(nowYear)年\(nowMonth + indexPath.section)月"
            head.lable.text = str
            return head
        }
        else{
            return UICollectionReusableView()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        self.title = "选择日期"
        self.view.backgroundColor = UIColor.white
        
    }
    
}

