//
//  ScenicSpotIntroduce.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotIntroduce: UIViewController ,ScrollEnabledDelegate,UIWebViewDelegate{

    lazy var costomWebView:UIWebView={
        let costomWebView = UIWebView.init(frame: self.view.bounds)
        costomWebView.scrollView.bounces = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor.white
        costomWebView.isUserInteractionEnabled = true
        return costomWebView
    }()
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(costomWebView)
        self.costomWebView.loadHTMLString(self.url, baseURL: nil)
        
    }

    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
////        print("实现代理")
//        self.costomWebView.scrollView.isScrollEnabled = true
    }
    func ScrollEnabledNo() {
////        print("实现代理")
//        self.costomWebView.scrollView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("介绍 页面已经销毁")
    }

    

}
