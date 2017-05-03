//
//  ScenicSpotPark.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotPark: UIViewController,ScrollEnabledDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
//        print("实现代理")
        //        self.WebView. = true
    }
    func ScrollEnabledNo() {
//        print("实现代理")
        //        self.WebView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("停车场 页面已经销毁")
    }
    
}
