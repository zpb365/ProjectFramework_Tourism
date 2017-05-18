//
//  InformationViewController.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import WebKit

class Public360ViewController: CustomTemplateViewController ,WKNavigationDelegate{
    
    var  url=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        self.view.backgroundColor = UIColor.white
        
        //创建wkwebview
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: self.view.frame.height))
        webview.navigationDelegate = self
        //加载请求
        webview.load(URLRequest(url: URL(string: self.url)!))
        //添加wkwebview
        self.view.addSubview(webview)
        
        let btn = UIButton(frame: CGRect(x: CGFloat(view.frame.size.width - 60), y: CGFloat(10), width: CGFloat(50), height: CGFloat(50)))
        btn.setImage(UIImage.init(named: "PanoramaClose"), for: .normal)
        btn.addTarget(self, action: #selector(self.CloseClickEvent), for: .touchUpInside)
        view.addSubview(btn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        
        
    }
    
    
    func CloseClickEvent(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
