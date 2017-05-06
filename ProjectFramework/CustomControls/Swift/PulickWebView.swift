//
//  PulickWebView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PulickWebView: UIView,UIWebViewDelegate{

    typealias CallbackValue=(_ value:CGFloat)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    lazy var costomWebView:UIWebView={
        let costomWebView = UIWebView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 10))
        costomWebView.scrollView.bounces = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor.white
        
        return costomWebView
    }()
    override init(frame:CGRect){
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        self.addSubview(costomWebView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: webViewDelegate
     func webViewDidStartLoad(_ webView: UIWebView){
        print("开始加载")
    }
     func webViewDidFinishLoad(_ webView: UIWebView){
        print("加载完成")
        
        var str = "document.body.style.fontSize = '13px';"
        
        webView.stringByEvaluatingJavaScript(from: str)
        str="<style> img {max-width:400px;height:auto'}</style>"
        webView.stringByEvaluatingJavaScript(from: str)
        
        let height = webView.scrollView.contentSize.height
        
        costomWebView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
        if (myCallbackValue != nil) {
            myCallbackValue!(height)
        }
    }
    func loadHtmlString(html:String) -> Void {
        costomWebView.loadHTMLString(html, baseURL: nil)
    }
}
