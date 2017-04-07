//
//  InformDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class InformDetail: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "公告通知"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#738FFE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    
}
