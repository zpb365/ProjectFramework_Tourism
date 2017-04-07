//
//  ScenerySpotDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenerySpotDetail: UIViewController {

    lazy var video: UIButton = {
        let video = UIButton(type: .custom)
        video.frame = CommonFunction.CGRect_fram(0, y: CommonFunction.kScreenHeight - 35, w: CommonFunction.kScreenWidth, h: 35)
        video.backgroundColor = UIColor.white
        video.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        video.setTitle("观看景区VR视频", for: .normal)
        video.setTitleColor(UIColor.black, for: .normal)
        video.setImage(UIImage.init(named: "vedio"), for: .normal)
        video.layer.borderWidth = 0.8
        video.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        return video
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "景区详情"
        self.initUI()
        // Do any additional setup after loading the view.
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
        tableView.frame = CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 64 - 35)
        
        self.view.addSubview(self.video)
    }

}
