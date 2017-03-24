//
//  ScenicIntroduceCell.swift
//  ProjectFramework
//
//  Created by 住朋购友 on 2017/3/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import WebKit

class ScenicIntroduceCell: UITableViewCell,UIWebViewDelegate {

    typealias CallbackValue=(_ value:CGFloat)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    lazy var costomWebView:UIWebView={
        let costomWebView = UIWebView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: self.contentView.frame.width, h: 50))
        costomWebView.scrollView.bounces = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor.white
 
        return costomWebView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(costomWebView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //数据源
    override func InitConfig(_ cell: Any) {
        costomWebView.loadHTMLString(cell as! String, baseURL: nil)
        
    }
    //MARK: webViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView){
        print("开始加载")
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        print("加载完成")
        
        let str = "document.body.style.fontSize = '13px';"
        
        webView.stringByEvaluatingJavaScript(from: str)        
//        var script: String = "var script = document.createElement('script');" +
//        "script.type = 'text/javascript';"
//        "script.text = \"function ResizeImages() { " +
//            "var img;" +
//            "var maxwidth=\(350 - 20);" +
//            "for(i=0;i <document.images.length;i++){" +
//            "img = document.images[i];" +
//            "if(img.width > maxwidth){" +
//            "img.width = maxwidth;" +
//            "}" +
//            "}" +
//            "}\";" +
//        "document.getElementsByTagName('head')[0].appendChild(script);"
//        webView.stringByEvaluatingJavaScript(from: script)
//        webView.stringByEvaluatingJavaScript(from: "ResizeImages();")
        let height = webView.scrollView.contentSize.height
        
        costomWebView.frame = CommonFunction.CGRect_fram(0, y: 0, w: self.contentView.frame.width, h: height)
        if (myCallbackValue != nil) {
            myCallbackValue!(height)
        }
    }
 
 
       
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
      

