//
//  HomePage.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

 

class HomePage: CustomTemplateViewController {
    
    weak var HoneMain:HoneMain?=nil
    private var SlidingDelegate:SlidingDelegate?   //协议
    
    let identifier="HomeCell"
    
    @IBOutlet weak var tableViewHead: UIView!  //tableview头视图
   
    @IBOutlet weak var tableView:UITableView!     //创建UItableview
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        tableView.frame=CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
         self.InitCongif(tableView)
    
        self.numberOfSections=2
        self.numberOfRowsInSection=5
        self.tableViewheightForRowAt=155
        self.SlidingDelegate=HoneMain
            let Imagelist  = ["index1","index2","index3","index4"]
        let vc = ScrollViewPageViewController(Enabletimer: true,   //是否启动滚动
                    timerInterval: 4,     //如果启用滚动，滚动秒数
                    ImageList:Imagelist  ,//图片
                    frame: tableViewHead.frame,
                    Callback_SelectedValue: nil ,
                    isJumpBtn: nil,
                    Callback_JumpValue: nil)
        
        tableViewHead.addSubview(vc.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor=UIColor.white
    
        let name=UILabel(frame: CGRect(x:  5, y: 10, width: 100, height: 20))
        name.text="热门景区"
        name.font=UIFont.systemFont(ofSize: 14)
        let lab = UILabel(frame: CGRect(x: self.view.frame.width-60, y: 10, width:50 , height: 20))
        lab.text="浏览更多"
        lab.font=UIFont.systemFont(ofSize: 12)
        lab.textColor=UIColor.lightGray
        lab.contentMode = .center
        view.addSubview(name)
        view.addSubview(lab)
 
        return view
    }
    
    //为表视图单元格提供数据，该方法是必须实现的方法
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomePageCell
        cell.accessoryType = UITableViewCellAccessoryType.none
   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    ///网络数据请求
    fileprivate func httpsPostData(){
       
    }
    
    //出错了点击我
    override func Error_Click() {
        httpsPostData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y>100){
           self.SlidingDelegate?.SlidingHidden()
        }else{
            self.SlidingDelegate?.SlidingShow()
            tableView.frame=CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
}
