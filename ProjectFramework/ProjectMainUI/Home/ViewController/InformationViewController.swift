//
//  InformationViewController.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import WebKit

class InformationViewController: CustomTemplateViewController ,WKNavigationDelegate{
    
    var  Content=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
         
        self.view.backgroundColor = UIColor.white
        
        //创建wkwebview
        let webview = WKWebView(frame: CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: self.view.frame.height-CommonFunction.NavigationControllerHeight))
        webview.navigationDelegate = self
        //加载请求
        webview.loadHTMLString(Content, baseURL: nil    )
        //添加wkwebview
        self.view.addSubview(webview)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        
        let str = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"
        webView.evaluateJavaScript(str) { (response, error) in
            
        }
    }

    
    
 

}
