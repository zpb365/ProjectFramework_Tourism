//
//  Attractions.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Attractions: CustomTemplateViewController {
   
    
    
    @IBOutlet weak var TableView: UITableView!
    let identiFier  = "PulickInformCell"
    let identiFier2 = "ScenerySpotCell"
    
    lazy var sectionHeaderView1: UIView={
            let sectionHeaderView1 = UIView().initSectionView(text: "公告信息活动通知")
             return sectionHeaderView1
    }()
    lazy var sectionHeaderView2: UIView={
        let sectionHeaderView2 = UIView().initSectionView(text: "景点介绍")
        return sectionHeaderView2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#738FFE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    //MARK: initUI
    func initUI() -> Void {
        
        self.InitCongif(TableView)
        self.TableView.frame = CommonFunction.CGRect_fram(0, y:CommonFunction.NavigationControllerHeight, w: self.view.frame.width, h: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        
    }
    //MARK: tableViewDelegate
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    var _numberOfRowsInSection = [4,10]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsInSection[section]
    }
    var _heightForRowAt = [CGFloat(35),CGFloat(80)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _heightForRowAt[indexPath.section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! PulickInformCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier2, for: indexPath) as! ScenerySpotCell
            return cell
        }
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //组头
    var _viewForHeaderInSection = [UIView(),UIView()]
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        _viewForHeaderInSection[0] = sectionHeaderView1
        _viewForHeaderInSection[1] = sectionHeaderView2
        return _viewForHeaderInSection[section]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let vc = CommonFunction.ViewControllerWithStoryboardName("InformDetail", Identifier: "InformDetail") as! InformDetail
            self.navigationController?.show(vc, sender: self  )
        }
        if (indexPath.section == 1) {
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenerySpotDetail", Identifier: "ScenerySpotDetail") as! ScenerySpotDetail
            self.navigationController?.show(vc, sender: self  )
        }
    }
}
