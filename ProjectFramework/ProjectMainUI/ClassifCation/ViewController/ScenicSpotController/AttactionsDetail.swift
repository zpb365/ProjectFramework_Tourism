//
//  AttactionsDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class AttactionsDetail: UIViewController ,UIWebViewDelegate{
    lazy var costomWebView:UIWebView={
        let costomWebView = UIWebView.init(frame: CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 64))
        costomWebView.scrollView.bounces = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor.white
        return costomWebView
    }()
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(costomWebView)
        self.costomWebView.loadHTMLString(self.url, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let str = "document.body.style.fontSize = '13px';"
        
        webView.stringByEvaluatingJavaScript(from: str)
        
        var  imageauto = "var script = document.createElement('script');"
        imageauto+="script.type = 'text/javascript';"
        imageauto+="script.text = \"function ResizeImages() { "
        imageauto+="var myimg,oldwidth;"
        imageauto+="var maxwidth = %f;"
        imageauto+="for(i=0;i <document.images.length;i++){"
        imageauto+="myimg = document.images[i];"
        imageauto+="if(myimg.width > maxwidth){"
        imageauto+="oldwidth = myimg.width;"
        imageauto+="myimg.width = %f;"
        imageauto+="}"
        imageauto+="}"
        imageauto+="}\";"
        imageauto+="document.getElementsByTagName('head')[0].appendChild(script);"
        
        imageauto = String(format: imageauto, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.width - 15)
        webView.stringByEvaluatingJavaScript(from: imageauto)
        webView.stringByEvaluatingJavaScript(from: "ResizeImages();")
        
        print("加载完成")
    }

}
